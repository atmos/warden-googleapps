# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{warden-googleapps}
  s.version = "0.0.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Corey Donohoe"]
  s.date = %q{2010-04-15}
  s.description = %q{A warden strategy to use Google's Federated OpenID with Google Apps}
  s.email = %q{atmos@atmos.org}
  s.extra_rdoc_files = ["LICENSE"]
  s.files = ["LICENSE", "README.md", "Rakefile", "lib/warden-googleapps", "lib/warden-googleapps/ca-bundle.crt", "lib/warden-googleapps/gapps_openid.rb", "lib/warden-googleapps/strategy.rb", "lib/warden-googleapps/user.rb", "lib/warden-googleapps/version.rb", "lib/warden-googleapps.rb"]
  s.homepage = %q{http://github.com/atmos/warden-googleapps}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{A warden strategy to use Google's Federated OpenID with Google Apps}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<warden>, ["~> 0.10"])
      s.add_runtime_dependency(%q<ruby-openid>, ["~> 2.1.7"])
    else
      s.add_dependency(%q<warden>, ["~> 0.10"])
      s.add_dependency(%q<ruby-openid>, ["~> 2.1.7"])
    end
  else
    s.add_dependency(%q<warden>, ["~> 0.10"])
    s.add_dependency(%q<ruby-openid>, ["~> 2.1.7"])
  end
end
