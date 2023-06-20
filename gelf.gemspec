Gem::Specification.new do |s|
  s.name = "gelf_redux"
  s.version = "3.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = ">= 1.9"
  s.require_paths = ["lib"]
  s.authors = ["Alexey Palazhchenko", "Lennart Koopmann", "Zac Sprackett", "Marcus Ilgner", "Sebastian Seidel", "Christian Rolle"]
  s.date = "2023-06-19"
  s.description = "Library to send GELF messages to Graylog logging server. Supports plain-text, GELF messages and exceptions via UDP, TCP and HTTPS"
  s.email = "admins@manet-marketing.de"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".gemtest",
    "CHANGELOG",
    "CONTRIBUTING.md",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "benchmarks/notifier.rb",
    "gelf.gemspec",
    "lib/gelf.rb",
    "lib/gelf/logger.rb",
    "lib/gelf/notifier.rb",
    "lib/gelf/severity.rb",
    "lib/gelf/transport/tcp.rb",
    "lib/gelf/transport/tcp_tls.rb",
    "lib/gelf/transport/udp.rb",
    "test/helper.rb",
    "test/test_logger.rb",
    "test/test_notifier.rb",
    "test/test_ruby_sender.rb",
    "test/test_severity.rb"
  ]
  s.homepage = "https://github.com/manet-marketing/gelf_redux"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "Library to send GELF messages to Graylog logging server."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('3.2.0') then
      s.add_development_dependency(%q<typhoeus>, ["~> 1.4.0"])
    end
    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<shoulda>, ["~> 2.11.3"])
      s.add_development_dependency(%q<rack>, ["< 2.0"])
      s.add_development_dependency(%q<mocha>, ["~> 1.1.0"])
      s.add_development_dependency(%q<test-unit>, ["~> 3.2.0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
    else
      s.add_dependency(%q<shoulda>, ["~> 2.11.3"])
      s.add_dependency(%q<rack>, ["< 2.0"])
      s.add_dependency(%q<mocha>, ["~> 1.1.0"])
      s.add_dependency(%q<test-unit>, ["~> 3.2.0"])
      s.add_dependency(%q<json>, [">= 0"])
    end
  else
    s.add_dependency(%q<shoulda>, ["~> 2.11.3"])
    s.add_dependency(%q<rack>, ["< 2.0"])
    s.add_dependency(%q<mocha>, ["~> 1.1.0"])
    s.add_dependency(%q<test-unit>, ["~> 3.2.0"])
    s.add_dependency(%q<json>, [">= 0"])
  end
end

