# == Schema Information
#
# Table name: password_recoveries
#
#  id           :bigint           not null, primary key
#  user_id      :bigint           not null
#  code         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#  token        :string
#
require 'rails_helper'

RSpec.describe PasswordRecovery, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
