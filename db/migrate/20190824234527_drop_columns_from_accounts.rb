class DropColumnsFromAccounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :latitude
    remove_column :accounts, :longitude
  end
end
