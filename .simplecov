SimpleCov.minimum_coverage 50
SimpleCov.start 'rails' do
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
  add_group 'Libraries', 'lib'
  # add_group 'Channels', 'app/channels'
  # add_group 'Uploaders', 'app/uploaders'

  # The classes below here are difficult to test, but if they are not working then nothing will work.
  add_filter 'app/controllers/application_controller.rb'

  add_filter 'app/channels'
  add_filter 'app/services/api/v1/auth/facebook_login_service.rb'
  add_filter 'lib/tasks'
  add_filter 'lib/throw_exception.rb'
  add_filter 'lib/facebook.rb'
  add_filter 'lib/json_web_token.rb'
  add_filter 'lib/my_harversine.rb'
end
