SimpleCov.minimum_coverage 80
SimpleCov.start 'rails' do
  add_group 'Serializers', 'app/serializers'
  add_group 'Services', 'app/services'
  add_group 'Libraries', 'lib'
  # add_group 'Channels', 'app/channels'
  # add_group 'Uploaders', 'app/uploaders'

  # The classes below here are difficult to test, but if they are not working then nothing will work.
  add_filter 'app/controllers/application_controller.rb'

  add_filter 'app/channels'
  add_filter 'lib/tasks'
  add_filter 'lib/utils'
  add_filter 'lib/throw_exception.rb'
  add_filter 'lib/facebook.rb'
  add_filter 'lib/json_web_token.rb'
  add_filter 'lib/my_haversine.rb'
end
