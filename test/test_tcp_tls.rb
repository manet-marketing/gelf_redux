require 'helper'
require 'socket'
require 'tempfile'

class TestTCPTLS < Test::Unit::TestCase
  # Self-signed cert, trusted via 'ca', with the given subjectAltName
  def self_signed(san)
    key = OpenSSL::PKey::RSA.new(2048)
    cert = OpenSSL::X509::Certificate.new
    cert.version = 2
    cert.serial = 1
    cert.subject = cert.issuer = OpenSSL::X509::Name.parse('/CN=test')
    cert.public_key = key.public_key
    cert.not_before = Time.now - 60
    cert.not_after = Time.now + 3600
    ef = OpenSSL::X509::ExtensionFactory.new(cert, cert)
    cert.add_extension(ef.create_extension('basicConstraints', 'CA:TRUE', true))
    cert.add_extension(ef.create_extension('subjectAltName', san))
    cert.sign(key, OpenSSL::Digest::SHA256.new)
    [cert, key]
  end

  def connect_to_server_with(san)
    cert, key = self_signed(san)
    ctx = OpenSSL::SSL::SSLContext.new
    ctx.cert = cert
    ctx.key = key
    server = OpenSSL::SSL::SSLServer.new(TCPServer.new('127.0.0.1', 0), ctx)
    port = server.to_io.addr[1]
    Thread.new { server.accept rescue nil }
    ca = Tempfile.new('ca').tap { |f| f.write(cert.to_pem); f.flush }
    GELF::Transport::TCPTLS.new([['127.0.0.1', port]], 'ca' => ca.path, 'no_default_ca' => true)
  ensure
    server&.close
  end

  context "tcp tls" do
    should "accept a certificate issued for the host" do
      assert_nothing_raised { connect_to_server_with('IP:127.0.0.1') }
    end

    should "reject a trusted certificate issued for another host" do
      assert_raise(OpenSSL::SSL::SSLError) { connect_to_server_with('DNS:attacker.example') }
    end
  end
end
