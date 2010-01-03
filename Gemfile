only :release do
  gem 'warden'
  gem 'sinatra',          '~>0.9.4'
  gem 'ruby-openid',      '=2.1.6',  :require_as => 'openid'
end

only :test do
  gem 'rake'
  gem 'rspec',                       :require_as => 'spec'
  gem 'rcov'
  gem 'bundler',          '>=0.7.0'
  gem 'webrat',           '~>0.5.0'
  gem 'rack-test',        '~>0.5.2', :require_as => 'rack/test'
  gem 'fakeweb',          '>=1.2.5'
  gem 'ParseTree',        '>=3.0.4', :require_as => [ ]
  gem 'randexp',          '>=0.1.4'
end

disable_system_gems

# vim:ft=ruby
