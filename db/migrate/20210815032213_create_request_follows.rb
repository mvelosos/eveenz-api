class CreateRequestFollows < ActiveRecord::Migration[6.1]
  def change
    create_table :request_follows do |t|
      t.references :requested_by, null: false, foreign_key: { to_table: :accounts }
      t.references :account, null: false, foreign_key: true
      t.boolean :accepted

      t.timestamps
    end
  end
end
