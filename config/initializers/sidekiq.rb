require 'sidekiq/web'

if Rails.env.production?
  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    username == ENV['SIDEKIQ_USERNAME'] && password == ENV['SIDEKIQ_PASSWORD']
  end
end

Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDISCLOUD_URL') { 'redis://localhost:6379/0' } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDISCLOUD_URL') { 'redis://localhost:6379/0' } }
end
