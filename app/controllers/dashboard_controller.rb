class DashboardController < ApplicationController
    before_action :authenticate_user! && :authenticate_admin!
    def index
        @items = Item.where(active: true)
        @deleted_items = Item.where(active: false)
    end

    private

    def authenticate_admin!
        if current_user
            if !current_user.admin?
                redirect_to root_path, alert: "Vous vous êtes sûrement perdu."
            end
        end
    end
end
