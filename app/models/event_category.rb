# == Schema Information
#
# Table name: event_categories
#
#  id          :bigint           not null, primary key
#  event_id    :bigint           not null
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class EventCategory < ApplicationRecord
  belongs_to :event
  belongs_to :category

  validates :event,    presence: true
  validates :category, presence: true
  validates :category_id, uniqueness: { scope: :event_id }
end
