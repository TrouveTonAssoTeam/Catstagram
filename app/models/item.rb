class Item < ApplicationRecord
    has_many :orderitems
    has_many :orders, through: :orderitems
    has_many :carts
end
