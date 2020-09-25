bundle check || bundle install
bundle exec rails s -u=puma &
bundle exec sidekiq