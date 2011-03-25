Warden::Strategies.add(:google_apps) do
  AxEmail     = 'http://axschema.org/contact/email'
  AxFirstName = 'http://axschema.org/namePerson/first'
  AxLastName  = 'http://axschema.org/namePerson/last'

  # Need to make sure that we have a pure representation of the query string.
  # Rails adds an "action" parameter which causes the openid gem to error
  def params
    @params ||= Rack::Utils.parse_query(request.query_string)
  end

  def authenticate!
    if params['openid.mode']
      response = consumer.complete(params, absolute_url(request, request.path))
      case response.status.to_s
      when 'success'
        profile_data = extract_ax_profile(response)
        user = Warden::GoogleApps::User.new(profile_data[:email],
                                            profile_data[:first_name],
                                            profile_data[:last_name],
                                            response.display_identifier)
        success!(user)
      when 'failure', 'setup_needed', 'cancel'
        fail!('Cound not log in')
      else
        fail!("Unknown Response Status: #{response.status.to_s}")
      end
    elsif params['RelayState']
      raise GoogleAppsMisconfiguredError, "Warden::GoogleApps only works with OpenID Federed Login for Google Apps"
    else
      begin
        google_discovery = OpenID.discover(open_id_endpoint)
      rescue StandardError => e
        fail!("Exception during OpenID discovery #{e.message}")
      end
      open_id_request = consumer.begin(google_discovery.first)
      add_ax_fields(open_id_request)
      redirect!(open_id_request.redirect_url(absolute_url(request), redirect_url(request)))
    end
  end

  private
  def consumer
    @consumer ||= ::OpenID::Consumer.new(request.session, open_id_store)
  end

  def open_id_store
    env['warden'].config[:open_id_store] || ::OpenID::Store::Filesystem.new("#{Dir.tmpdir}/tmp/openid")
  end

  def google_apps_domain
    env['warden'].config[:google_apps_domain]
  end

  def domain
    'https://www.google.com/accounts/o8/site-xrds?hd=%s' % google_apps_domain
  end

  def endpoint
    env['warden'].config[:google_apps_endpoint]
  end

  def open_id_endpoint
    endpoint || domain
  end

  def redirect_url(request)
    env['warden'].config[:google_apps_redirect_url] || absolute_url(request, request.path)
  end

  def add_ax_fields(open_id_request)
    ax_request = ::OpenID::AX::FetchRequest.new

    [ AxEmail, AxFirstName, AxLastName ].each do |field|
      ax_request.add(::OpenID::AX::AttrInfo.new(field, nil, true))
    end
    open_id_request.add_extension(ax_request)
  end

  def extract_ax_profile(open_id_response)
    profile = { }
    if ax_response = OpenID::AX::FetchResponse.from_success_response(open_id_response)
      profile_data         = ax_response.data
      profile[:email]      = profile_data[AxEmail]
      profile[:last_name]  = profile_data[AxLastName]
      profile[:first_name] = profile_data[AxFirstName]
    end
    profile
  end

  def absolute_url(request, suffix = nil)
    port_part = case request.scheme
                when "http"
                  request.port == 80 ? "" : ":#{request.port}"
                when "https"
                  request.port == 443 ? "" : ":#{request.port}"
                end
          "#{request.scheme}://#{request.host}#{port_part}#{suffix}"
  end
end
