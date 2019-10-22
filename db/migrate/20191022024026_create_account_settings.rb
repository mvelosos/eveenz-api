class CreateAccountSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :account_settings do |t|
      t.references :account, foreign_key: true
      t.float :distance_radius, :default => 10.0, :null =>  false

      t.timestamps
    end
  end
end
