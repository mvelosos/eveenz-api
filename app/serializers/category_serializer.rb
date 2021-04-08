# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  discarded_at :datetime
#
class CategorySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :titleized_name

  def titleized_name
    object.name.titleize
  end
end
