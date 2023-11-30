class CartsController < ApplicationController
    include CartsHelper

    before_action :require_login
    
    def show
        @items_in_cart = JoinTableItemsCart.where(cart_id:current_user.cart.id)
    end

    def create
    end
  
    def update
    end
  
    def destroy
    end

    def increment_quantity
        @item = JoinTableItemsCart.find(params[:id])
        @item.quantity += 1

        if @item.save
            redirect_to cart_path, notice: 'Quantité modifiée !'
        else 
            redirect_to cart_path, alert: 'Un problème est survenu.'
        end
    end

    def decrement_quantity
        @item = JoinTableItemsCart.find(params[:id])
        @item.quantity -= 1

        if @item.quantity == 0
            @item.destroy
        else 
            if @item.save
                redirect_to cart_path, notice: 'Quantité modifiée !'
            else 
                redirect_to cart_path, alert: 'Un problème est survenu.'
            end
        end
    end

    def set_cart
        # Logique pour définir le panier
        # Par exemple, trouver le panier actuel de l'utilisateur connecté
        @cart = current_user.cart # C'est un exemple, vous devez définir cette logique en fonction de votre application
      end

end
