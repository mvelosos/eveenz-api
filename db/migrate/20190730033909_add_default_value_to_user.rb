class AddDefaultValueToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :provider, :string, default: 'api'
  end
end
