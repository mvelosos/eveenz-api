source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'rails', '~> 6.0.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'redis', '~> 4.0'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'rack-cors'
gem 'rack-attack'
gem 'active_model_serializers', '~> 0.10.9'
gem 'figaro', '~> 1.1', '>= 1.1.1'
gem 'searchkick'
gem 'jwt'
gem 'config'
gem 'koala'
gem "aws-sdk-s3"
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'mini_magick'
gem "sentry-raven"
gem 'newrelic_rpm'
gem 'haversine', '~> 0.3.2'

group :development, :test do
  gem 'pry-byebug'
  gem 'rspec-rails', '~> 3.8'
  gem 'ffaker'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
end
