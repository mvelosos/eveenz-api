# == Schema Information
#
# Table name: localizations
#
#  id               :bigint           not null, primary key
#  localizable_type :string
#  localizable_id   :bigint
#  latitude         :decimal(11, 8)
#  longitude        :decimal(11, 8)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Localization < ApplicationRecord
  include Discard::Model

  belongs_to :localizable, polymorphic: true

  validates :latitude,  presence: true, if: -> { !belongs_to_account? }
  validates :longitude, presence: true, if: -> { !belongs_to_account? }

  private

  def belongs_to_account?
    localizable_type == 'Account'
  end
end
