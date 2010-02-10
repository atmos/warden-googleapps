warden-googleapps
=================

A Warden middleware for google apps.  It needs a little work but definitely authenticates you just fine in Rack apps.

Example
=======
Gemfile
-------
    source :gemcutter

    gem 'haml',                '~>2.2.0'
    gem 'warden-googleapps',    '=0.0.3'

    group :development do
      gem 'shotgun'
    end

app.rb
------
    module DirectoryAdmin
      class App < Sinatra::Default
        disable :show_errors
        disable :show_exceptions

        use Warden::Manager do |manager|
          manager.default_strategies :google_apps
          manager.failure_app = BadAuthentication

          manager[:google_apps_domain]   = 'example.org'
          # manager[:google_apps_endpoint] = 'http://www.google.com/accounts/o8/id' # this is gmail
        end

        helpers do
          def ensure_authenticated
            unless env['warden'].authenticate!
              throw(:warden)
            end
          end

          def user
            env['warden'].user
          end
        end

        get '/' do
          ensure_authenticated
          haml "%h2= 'Hello There, #{user.full_name}!'"
        end

        get '/logout' do
          env['warden'].logout
          haml "%h2= 'Peace!'"
        end
      end

      class BadAuthentication < Sinatra::Default
        get '/unauthenticated' do
          status 403
          haml "%h3= 'Unable to authenticate, sorry bud.'"
        end
      end
    end

Enabling on GMail
==================
It should just work, even for localhost.

Enabling on Google Apps for Domains
===================================
Be sure you have Federated Login using OpenID enabled under your Advanced Settings Tab

![Your Google Apps Admin Dashboard](http://img.skitch.com/20100103-cdjtbyyw2xsbwya92r6gcd47hr.jpg "Check the box to enable")

Developing
==========
    % gem install bundler
    % bundle install
    % bundle exec rake repackage
