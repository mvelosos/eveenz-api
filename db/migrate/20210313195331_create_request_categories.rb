class CreateRequestCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :request_categories do |t|
      t.bigint :requested_by_id
      t.string :name
      t.boolean :approved
      t.bigint :approved_by_id
      t.datetime :approved_at

      t.timestamps
      t.datetime :discarded_at
    end
    add_index :request_categories, :discarded_at
  end
end
