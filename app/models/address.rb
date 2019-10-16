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
#

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street,       presence: true
  validates :number,       presence: true
  validates :neighborhood, presence: true
  validates :zip_code,     presence: true
  validates :city,         presence: true
  validates :state,        presence: true
  validates :country,      presence: true

end
