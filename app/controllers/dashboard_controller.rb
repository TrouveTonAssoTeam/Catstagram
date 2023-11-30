class DashboardController < ApplicationController
    before_action :authenticate_user! && :check_admin
    def index
        @items = Item.where(active: true)
        @deleted_items = Item.where(active: false)
    end

    private

    def check_admin
        if current_user && current_user.admin?
          # User is authenticated and is an admin
        else
          redirect_to root_path, alert: "Vous avez dû vous perdre."
        end
      end
end
