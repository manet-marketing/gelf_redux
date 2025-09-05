Gem::Specification.new do |s|
  s.name = "gelf_redux"
  gem_version = Gem::Version.new(File.read('VERSION').strip)
  s.version = gem_version
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = ">= 2.6"
  s.require_paths = ["lib"]
  s.authors = ["Alexey Palazhchenko", "Lennart Koopmann", "Zac Sprackett", "Marcus Ilgner", "Christian Rolle", "Sebastian Seidel", "Ronald Sacher"]
  s.description = "Library to send GELF messages to Graylog logging server. Supports plain-text, GELF messages and exceptions via UDP, TCP and HTTP(S)"
  s.email = "admins@manet-marketing.de"
  s.files = Dir["{lib}/**/*", "LICENSE", "README.md"]
  s.homepage = "https://github.com/manet-marketing/gelf_redux"
  s.licenses = ["MIT"]
  s.summary = "Library to send GELF messages to Graylog logging server."

  if gem_version >= Gem::Version.new('3.2.0') && gem_version < Gem::Version.new('4.0.0')
    s.add_runtime_dependency('typhoeus', '~> 1.4.0')
  end
  s.add_development_dependency(%q<shoulda>, ["~> 4.0.0"])
  s.add_development_dependency(%q<mocha>, ["~> 2.0.4"])
  s.add_development_dependency(%q<test-unit>, ["~> 3.6.0"])
  s.add_development_dependency(%q<simplecov>, ["~> 0.20.0"])
  s.add_development_dependency(%q<webmock>, ["~> 3.18.1"])
  s.add_development_dependency(%q<timecop>, ["~> 0.9.6"])
  s.add_development_dependency(%q<rake>)
  s.add_runtime_dependency(%q<json>, [">= 0"])

end