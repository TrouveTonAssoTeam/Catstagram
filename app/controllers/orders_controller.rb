class OrdersController < ApplicationController
    before_action :authenticate_user! && :is_the_owner_of_the_order?, only: [:show]

    def show
        @order = Order.find(params[:id])
    end

    private

    def is_the_owner_of_the_order?
        if current_user
            if !Order.find(params[:id]).user == current_user
                redirect_to root_path, alert: "Vous n'avez pas le droit de voir cette commande."
            end
        end
    end
end
