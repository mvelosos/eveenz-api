source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'active_model_serializers', '~> 0.10.9'
gem 'active_storage_base64', '~> 1.1.0'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'awrence'
gem 'aws-sdk-s3'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'config'
gem 'discard', '~> 1.2'
gem 'faraday'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'haversine', '~> 0.3.2'
gem 'jwt'
gem 'kaminari'
gem 'koala'
gem 'mini_magick'
gem 'pg', '>= 0.18', '< 2.0'
gem 'plissken', '~> 1.3', '>= 1.3.1'
gem 'puma', '~> 3.12'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 6.0.3'
gem 'redis', '~> 4.0'
gem 'searchkick'
gem 'sentry-raven'
gem 'sidekiq'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 4.0'
  gem 'rubocop', require: false
end

group :development do
  gem 'annotate'
  gem 'letter_opener_web', '~> 1.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'simplecov', require: false
end
