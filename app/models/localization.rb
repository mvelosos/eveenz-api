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
#  discarded_at     :datetime
#

class Localization < ApplicationRecord
  include Discard::Model

  belongs_to :localizable, polymorphic: true

  validates :latitude,  presence: true, if: -> { belongs_to_event? }
  validates :longitude, presence: true, if: -> { belongs_to_event? }

  private

  def belongs_to_event?
    localizable_type == 'Event'
  end
end
