class CreatePostShares < ActiveRecord::Migration
  def change
    create_table :post_shares do |t|
      t.integer :post_id, null: false
      t.integer :friend_circle_id, null: false

      t.timestamps
    end
    add_index :post_shares, :post_id
    add_index :post_shares, :friend_circle_id
  end
end
