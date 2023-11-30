class CartsController < ApplicationController
    include CartsHelper

    before_action :require_login
    before_action :only_current_cart
    before_action :set_cart, only: [:show, :update, :destroy]
    
    def show
        @items_in_cart = JoinTableItemsCart.where(cart_id:current_user.cart.id)
    end

    def create
    end
  
    def update
    end
  
    def destroy
    end

    def set_cart
        # Logique pour définir le panier
        # Par exemple, trouver le panier actuel de l'utilisateur connecté
        @cart = current_user.cart # C'est un exemple, vous devez définir cette logique en fonction de votre application
      end

end
