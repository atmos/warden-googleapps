module Warden
  module GoogleApps
    class User < Struct.new(:email, :first_name, :last_name, :identity_url)
      def full_name
      "#{first_name} #{last_name}"
      end
    end
  end
end
