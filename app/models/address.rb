# == Schema Information
#
# Table name: addresses
#
#  id               :bigint           not null, primary key
#  addressable_type :string
#  addressable_id   :bigint
#  street           :string
#  number           :string
#  complement       :string
#  neighborhood     :string
#  zip_code         :string
#  city             :string
#  state            :string
#  country          :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  discarded_at     :datetime
#

class Address < ApplicationRecord
  include Discard::Model

  belongs_to :addressable, polymorphic: true

  validates :street,       presence: true, if: -> { belongs_to_event? }
  validates :number,       presence: true, if: -> { belongs_to_event? }
  validates :neighborhood, presence: true, if: -> { belongs_to_event? }
  validates :zip_code,     presence: true, if: -> { belongs_to_event? }
  validates :city,         presence: true, if: -> { belongs_to_event? }
  validates :state,        presence: true, if: -> { belongs_to_event? }
  validates :country,      presence: true, if: -> { belongs_to_event? }

  private

  def belongs_to_event?
    addressable_type == 'Event'
  end
end
