Gem::Specification.new do |s|
  s.name = "gelf_redux"
  s.version=File.read('VERSION')

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = ">= 2.5"
  s.require_paths = ["lib"]
  s.authors = ["Alexey Palazhchenko", "Lennart Koopmann", "Zac Sprackett", "Marcus Ilgner", "Sebastian Seidel", "Christian Rolle"]
  s.description = "Library to send GELF messages to Graylog logging server. Supports plain-text, GELF messages and exceptions via UDP, TCP and HTTP(S)"
  s.email = "admins@manet-marketing.de"
  s.files = Dir["{lib}/**/*", "LICENSE", "README.md"]
  s.homepage = "https://github.com/manet-marketing/gelf_redux"
  s.licenses = ["MIT"]
  s.summary = "Library to send GELF messages to Graylog logging server."

  if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('3.2.0') && Gem::Version.new(Gem::VERSION) < Gem::Version.new('4.0.0') then
    s.add_runtime_dependency(%q<typhoeus>, ["~> 1.4.0"])
  end
  s.add_development_dependency(%q<shoulda>, ["~> 2.11.3"])
  s.add_development_dependency(%q<rack>, ["< 2.0"])
  s.add_development_dependency(%q<mocha>, ["~> 1.1.0"])
  s.add_development_dependency(%q<test-unit>, ["~> 3.2.0"])
  s.add_runtime_dependency(%q<json>, [">= 0"])

end