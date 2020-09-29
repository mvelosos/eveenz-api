# == Schema Information
#
# Table name: account_settings
#
#  id              :bigint           not null, primary key
#  account_id      :bigint
#  distance_radius :float            default(10.0), not null
#  unit            :string           default("km"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  discarded_at    :datetime
#

require 'rails_helper'

RSpec.describe AccountSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
