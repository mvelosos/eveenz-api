# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

10.times do |_|
  account = FactoryBot.create(:account)
  FactoryBot.create(:event, account: account)
end

Account.reindex
Event.reindex
