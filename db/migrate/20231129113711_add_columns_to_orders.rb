class AddColumnsToOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orderitems do |t|
      t.references :item, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end

    add_reference :orders, :user, null: false, foreign_key: true
    add_reference :orders, :orderitems, foreign_key: true
  end
end
