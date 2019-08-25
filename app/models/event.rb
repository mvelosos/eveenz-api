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
  has_one    :address,      as: :addressable
  has_one    :localization, as: :localizable

  before_create :build_address_and_localization

  def build_address_and_localization
    self.build_address
    self.build_localization
  end

end
