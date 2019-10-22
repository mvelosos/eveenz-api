class AddColumnUnitToAccountSettings < ActiveRecord::Migration[5.2]
  def change
    add_column :account_settings, :unit, :string, :default => 'km', :null =>  false
  end
end
