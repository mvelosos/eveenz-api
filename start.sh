bundle check || bundle install
bundle exec sidekiq &
bundle exec rails s -u=puma
