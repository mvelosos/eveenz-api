# == Schema Information
#
# Table name: request_categories
#
#  id              :bigint           not null, primary key
#  requested_by_id :bigint
#  name            :string
#  approved        :boolean
#  approved_by_id  :bigint
#  approved_at     :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#
class RequestCategory < ApplicationRecord
  include Discard::Model

  belongs_to :requested_by, class_name: 'Account', foreign_key: 'requested_by_id'
  belongs_to :approved_by,  class_name: 'Account', foreign_key: 'approved_by_id', optional: true

  validates :name,         presence: true
  validates :requested_by, presence: true
end
