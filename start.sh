bundle check || bundle install
bundle exec sidekiq &
bundle exec rails s -b 0.0.0.0 -p 3000 -u=puma
