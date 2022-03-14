class EventPresence < ApplicationRecord
  belongs_to :event
  belongs_to :account

  validates :account, uniqueness: { scope: :event, message: 'Você já confirmou presença neste evento' }

  after_create :reload_uuid

  private

  def reload_uuid
    self[:uuid] = self.class.where(id: id).pluck(:uuid).first
  end
end
