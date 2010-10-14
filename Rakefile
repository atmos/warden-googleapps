require 'rake/gempackagetask'
require 'rubygems/specification'
require 'date'
require 'bundler'

require 'lib/warden-googleapps/version'

task :default => [:spec]

require 'spec/rake/spectask'
desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = %w(-fs --color)
  t.spec_opts << '--loadby' << 'random'

  t.rcov_opts << '--exclude' << 'spec,.bundle'
  t.rcov = ENV.has_key?('NO_RCOV') ? ENV['NO_RCOV'] != 'true' : true
  t.rcov_opts << '--text-summary'
  t.rcov_opts << '--sort' << 'coverage' << '--sort-reverse'
end

GEM         = "warden-googleapps"
GEM_VERSION = Warden::GoogleApps::VERSION
AUTHOR      = "Corey Donohoe"
EMAIL       = "atmos@atmos.org"
HOMEPAGE    = "http://github.com/atmos/warden-googleapps"
SUMMARY     = "A warden strategy to use Google's Federated OpenID with Google Apps"

spec = Gem::Specification.new do |s|
  s.name = GEM
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["LICENSE"]
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE

  bundle = Bundler::Definition.build('Gemfile', 'Gemfile.lock', { })
  bundle.dependencies.each do |dep|
    next unless dep.groups.include?(:runtime)
    s.add_dependency(dep.name, dep.version_requirements.to_s)
  end

  s.require_path = 'lib'
  s.files = %w(LICENSE README.md Rakefile) + Dir.glob("{lib}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "create a gemspec file"
task :make_spec do
  File.open("#{GEM}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end
