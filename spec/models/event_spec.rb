# == Schema Information
#
# Table name: events
#
#  id           :bigint           not null, primary key
#  account_id   :bigint
#  name         :string
#  description  :text
#  active       :boolean          default(TRUE)
#  kind         :string
#  date         :date
#  time         :time
#  tags         :text             default([]), is an Array
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#

require 'rails_helper'

RSpec.describe Event, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
