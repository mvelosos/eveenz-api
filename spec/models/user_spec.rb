# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  uid             :string
#  provider        :string           default("api")
#  active          :boolean          default(TRUE)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without username' do
    user = build(:user, username: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid without password' do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid with invalid username' do
    user = build(:user, username: "#{FFaker::Lorem.word}@-.#{FFaker::Lorem.word}")
    expect(user).to_not be_valid
  end

  it 'is not valid with invalid email' do
    user = build(:user, email: FFaker::Lorem.word)
    expect(user).to_not be_valid
  end

  it 'is not valid with already used email' do
    email = FFaker::Internet.free_email
    user1 = create(:user, email: email)
    user2 = build(:user, email: email)
    expect(user1).to be_valid
    expect(user2).to_not be_valid
  end

  it 'is not valid with password less than 6 characters' do
    user = build(:user, password: FFaker::Internet.password[1..5])
    expect(user).to_not be_valid
  end

end
