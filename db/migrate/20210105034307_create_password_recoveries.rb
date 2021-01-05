class CreatePasswordRecoveries < ActiveRecord::Migration[6.0]
  def change
    create_table :password_recoveries do |t|
      t.references :user, null: false, foreign_key: true
      t.string :code

      t.timestamps
      t.datetime :discarded_at
    end
    add_index :password_recoveries, :discarded_at
  end
end
