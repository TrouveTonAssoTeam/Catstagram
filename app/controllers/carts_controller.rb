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
end
