require 'helper'

class TestHttp < Test::Unit::TestCase
  context "https" do
    setup do
      Socket.stubs(:gethostname).returns('stubbed_hostname')
      @fake_time = Time.now
      Timecop.freeze(@fake_time)
    end
    should "send request without additional path and headers" do
      @logger = GELF::Logger.new(
        'foo.example.com',
        443,
        'WAN',
        { protocol: GELF::Protocol::HTTPS }
      )

      WebMock.stub_request(:post, "https://foo.example.com/").
        with(
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby'
          })
      @logger.info "foobar"
      @line = __LINE__
      assert_requested :post, "https://foo.example.com/",
                       headers: { 'Accept' => 'application/json',
                                  'Content-Type' => 'application/json' },
                       body: {
                         version: "1.1",
                         timestamp: @fake_time.utc.to_f,
                         host: "stubbed_hostname",
                         level: 1,
                         short_message: "foobar",
                         file: __FILE__,
                         line: @line - 1
                       },
                       times: 1

    end

    should "send request with additional path and headers and different port" do
      @logger = GELF::Logger.new(
        'foo.example.com',
        8443,
        'WAN',
        { protocol: GELF::Protocol::HTTPS, path: 'foo', headers: { foo: 'foo' } }
      )

      WebMock.stub_request(:post, "https://foo.example.com:8443/foo").
        with(
          headers: {
            'Accept' => 'application/json',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Ruby',
            'Foo' => 'foo',
          })
      @logger.info "foobar"
      @line = __LINE__
      assert_requested :post, "https://foo.example.com:8443/foo",
                       headers: { 'Accept' => 'application/json',
                                  'Content-Type' => 'application/json',
                                  'Foo' => 'foo',
                       },
                       body: {
                         version: "1.1",
                         timestamp: @fake_time.utc.to_f,
                         host: "stubbed_hostname",
                         level: 1,
                         short_message: "foobar",
                         file: __FILE__,
                         line: @line - 1
                       },
                       times: 1

    end

  end
end