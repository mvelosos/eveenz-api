# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string
#  bio        :text
#  latitude   :decimal(11, 8)
#  longitude  :decimal(11, 8)
#  popularity :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Account < ApplicationRecord

  belongs_to :user
  has_one_attached :avatar

  after_create :set_default_avatar

  def set_default_avatar
    self.avatar.attach(io: File.open('./app/assets/images/default_avatar.png'), filename: 'default_avatar.png')
  end

end
