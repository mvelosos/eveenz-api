# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#
class Category < ApplicationRecord
  include Discard::Model

  validates :name, presence: true
  validates :name, uniqueness: true

  has_many   :event_categories, dependent: :destroy
  has_many   :events, through: :event_categories
end
