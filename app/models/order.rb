class Order < ApplicationRecord
    belongs_to :user 
    has_many :orderitems
    has_many :items, through: :orderitems
end
