# == Schema Information
#
# Table name: events
#
#  id            :bigint           not null, primary key
#  uuid          :uuid             not null
#  account_id    :bigint
#  name          :string
#  description   :text
#  active        :boolean          default(TRUE)
#  privacy       :string
#  start_date    :date
#  end_date      :date
#  start_time    :time
#  end_time      :time
#  undefined_end :boolean          default(FALSE)
#  external_url  :string
#  minimum_age   :integer
#  tags          :text             default([]), is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  discarded_at  :datetime
#

class Event < ApplicationRecord
  include Discard::Model
  include PgSearch::Model

  PUBLIC_PRIVACY  = 'public'.freeze
  PRIVATE_PRIVACY = 'private'.freeze
  SECRET_PRIVACY  = 'secret'.freeze

  PRIVACIES = [
    PUBLIC_PRIVACY,
    PRIVATE_PRIVACY,
    SECRET_PRIVACY
  ].freeze

  belongs_to :account

  has_one    :address,      as: :addressable, dependent: :destroy
  has_one    :localization, as: :localizable, dependent: :destroy
  has_many   :event_categories, dependent: :destroy
  has_many   :categories, through: :event_categories
  has_many   :event_presences, dependent: :destroy

  has_many_base64_attached :images

  accepts_nested_attributes_for :address,      update_only: true
  accepts_nested_attributes_for :localization, update_only: true
  accepts_nested_attributes_for :event_categories, allow_destroy: true

  validates :name,          presence: true
  validates :start_date,    presence: true
  validates :start_time,    presence: true
  validates :end_date,      presence: true, unless: -> { undefined_end? }
  validates :end_time,      presence: true, unless: -> { undefined_end? }
  validates :privacy,       presence: true, inclusion: { in: PRIVACIES }

  before_create :check_undefined_end

  pg_search_scope :search_name,
                  against: :name,
                  ignoring: :accents,
                  using: {
                    trigram: {
                      threshold: 0.2
                    }
                  }

  private

  def check_undefined_end
    return unless undefined_end

    self.end_date = nil
    self.end_time = nil
  end
end
