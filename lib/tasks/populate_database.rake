namespace :populate_database do
  desc 'Populate Categories'
  task populate_categories: :environment do
    Category.create(name: 'happy-hour')
  end
end
