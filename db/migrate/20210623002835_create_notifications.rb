class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :account, foreign_key: true
      t.references :notifiable, polymorphic: true, null: false
      t.string :notification_type
      t.boolean :viewed, default: false

      t.timestamps
    end

    add_column :notifications, :discarded_at, :datetime
    add_index :notifications, :discarded_at
  end
end
