class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.text :bio
      t.integer :popularity, :default => 0

      t.timestamps
    end
    add_column :accounts, :discarded_at, :datetime
    add_index :accounts, :discarded_at
  end
end
