module Api
  module V1
    class AuthenticationService

      def initialize(access_token)
        @access_token = access_token
      end

      def facebook_login
        fb_user = Facebook.info(@access_token)
        find_or_create_fb_user(fb_user)
      end
      
      private

        def find_or_create_fb_user(fb_user)
          user = User.find_by_email(fb_user['email'])
          if user
            return user
          else
            username = generate_username_from_email(fb_user['email'])
            User.create(username: username, 
                        email: fb_user['email'],
                        password: SecureRandom.hex(16),
                        uid: fb_user['id'],
                        provider: Settings.Providers.FACEBOOK
                        )
          end 
        end

        def generate_username_from_email(email)
          username = email.split('@')[0]
          username += rand(999).to_s
        end

    end
  end
end