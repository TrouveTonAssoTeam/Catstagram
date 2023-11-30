class CreateJoinTableItemsCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :join_table_items_carts do |t|
      t.belongs_to :item, null: false, foreign_key: true
      t.belongs_to :cart, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
