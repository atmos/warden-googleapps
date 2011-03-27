# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "warden-googleapps/version"

Gem::Specification.new do |s|
  s.name        = "warden-googleapps"
  s.version     = Warden::GoogleApps::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Corey Donohoe"]
  s.email       = ["atmos@atmos.org"]
  s.homepage    = "http://github.com/atmos/warden-googleapps"
  s.summary     = %q{A warden strategy to use Google"s Federated OpenID with Google Apps}
  s.description = s.summary

  s.rubyforge_project = "warden-googleapps"

  s.add_dependency "warden"
  s.add_dependency "ruby-openid"

  s.add_development_dependency "ruby-openid"
  s.add_development_dependency "sinatra",    "~>1.0"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec",      "~>1.2.9"
  s.add_development_dependency "rcov"
  s.add_development_dependency "bundler",    "~>1.0.10"
  s.add_development_dependency "webrat",     "~>0.7.0"
  s.add_development_dependency "rack-test",  "~>0.5.0"
  s.add_development_dependency "fakeweb",    ">=1.2.6"
  s.add_development_dependency "ParseTree",  ">=3.0.4"
  s.add_development_dependency "randexp",    ">=0.1.4"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
