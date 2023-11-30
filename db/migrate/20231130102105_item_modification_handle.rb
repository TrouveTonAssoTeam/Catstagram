class ItemModificationHandle < ActiveRecord::Migration[7.1]
  def change
    # Add an active column to items in case we wan't to 'delete' an item and keep it for the orders
    add_column :items, :active, :boolean, default: true

    # Add a price column to orderitems in case the price of the item changes and to let the correct price paid for the order
    add_column :orderitems, :price, :decimal
  end
end
