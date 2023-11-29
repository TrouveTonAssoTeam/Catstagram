class Item < ApplicationRecord
    has_many :orders
    has_many :carts
    has_one_attached :image
end
