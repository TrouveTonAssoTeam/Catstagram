class Cart < ApplicationRecord
  belongs_to :user
  has_many :items
  # Cette commande effectue le calcul du panier
    def total
      cart_items.map { |item| item.quantity * item.price }.sum
    end
  end

