class CreateAccountSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :account_settings do |t|
      t.references :account, foreign_key: true
      t.float :distance_radius, :default => 10.0, :null =>  false
      t.string :unit, :default => 'km', :null =>  false
      t.boolean :private, default: false

      t.timestamps
    end
    add_column :account_settings, :discarded_at, :datetime
    add_index :account_settings, :discarded_at
  end
end
