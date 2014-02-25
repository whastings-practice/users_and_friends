class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.integer :post_id, null: false
      t.string :title, null: false
      t.string :url, limit: 1024

      t.timestamps
    end
    add_index :links, :post_id
  end
end
