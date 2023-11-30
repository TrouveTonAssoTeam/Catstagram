class UpdateItemToStripe < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :stripe_product, :string
    add_column :items, :stripe_price, :string

    add_column :orders, :stripe_id, :string
  end
end
