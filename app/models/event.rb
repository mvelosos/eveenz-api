# == Schema Information
#
# Table name: events
#
#  id          :bigint           not null, primary key
#  account_id  :bigint
#  name        :string
#  description :text
#  active      :boolean          default(TRUE)
#  kind        :string
#  date        :date
#  time        :time
#  tags        :text             default([]), is an Array
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Event < ApplicationRecord
  belongs_to :account

  has_one    :address,      as: :addressable, dependent: :destroy
  has_one    :localization, as: :localizable, dependent: :destroy

  accepts_nested_attributes_for :address,      allow_destroy: true
  accepts_nested_attributes_for :localization, allow_destroy: true

  has_many_attached :images

  validates :name, presence: true
  validates :date, presence: true
  validates :time, presence: true

  acts_as_followable

end
