# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  uuid         :uuid             not null
#  user_id      :bigint
#  name         :string
#  bio          :text
#  popularity   :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#
class AccountFollowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :uuid,
             :name,
             :username,
             :avatar_url

  def username
    object.user.username
  end

  def avatar_url
    rails_blob_url(object.avatar)
  end
end
