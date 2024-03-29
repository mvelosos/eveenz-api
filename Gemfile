source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'active_model_serializers', '~> 0.10.12'
gem 'active_storage_base64', '~> 1.2.0'
gem 'acts_as_follower', github: 'mvelosos/acts_as_follower', branch: 'master'
gem 'apple_auth', '~> 1.0'
gem 'awrence'
gem 'aws-sdk-s3'
gem 'bcrypt', '~> 3.1.16'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'config'
gem 'discard', '~> 1.2'
gem 'faraday'
gem 'haversine', '~> 0.3.2'
gem 'image_processing', '~> 1.0'
gem 'jwt'
gem 'kaminari'
gem 'koala'
gem 'pg', '>= 0.18', '< 2.0'
gem 'pg_search', '~> 2.3', '>= 2.3.5'
gem 'plissken', '~> 1.4'
gem 'puma', '~> 5.5'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 6.1.4'
gem 'redis', '~> 4.5'
gem 'sentry-raven'
gem 'sidekiq'

group :development, :test do
  gem 'bullet', '~> 6.1', '>= 6.1.5'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop', require: false
end

group :development do
  gem 'annotate'
  gem 'letter_opener_web', '~> 1.4'
  gem 'listen', '>= 3.0.5', '< 3.8'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'database_cleaner-active_record'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
end
