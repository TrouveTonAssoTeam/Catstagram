class CartsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_cart, only: [:show, :edit, :update, :destroy]
    
    def show

    end

    private

    def set_cart
        set_cart @cart = current_user.cart || current_user.create_cart
    end

    def cart_params
        params.require(:cart).permit(:user_id) 
    end

    def add_to_cart
        item = Item.find(params[:item_id])
        current_user.cart.items << item unless current_user.cart.items.include?(item)
        redirect_to current_user.cart, notice: 'Article ajouté au panier!'
    end


    def remove_item
        item = Item.find(params[:item_id])
        current_user.cart.items.delete(item)
        redirect_to cart_path(current_user.cart), notice: 'Article supprimé du panier.'
    end
    
end