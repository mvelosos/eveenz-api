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
class AccountFollowNotificationSerializer < ActiveModel::Serializer
  attributes :name,
             :username

  def username
    object.user.username
  end
end
