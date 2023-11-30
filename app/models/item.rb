class Item < ApplicationRecord
    has_many :orderitems
    has_many :orders, through: :orderitems
    has_many :carts
    has_one_attached :image
    has_many :join_table_items_carts, dependent: :nullify
end
