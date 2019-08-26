# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  name       :string
#  bio        :text
#  popularity :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
