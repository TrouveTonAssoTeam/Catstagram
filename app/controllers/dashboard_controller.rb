class DashboardController < ApplicationController
    before_action :authenticate_user! && :authenticate_admin!
    def index
        @items = Item.all
    end

    def authenticate_admin!
        if current_user
            if !current_user.admin?
                redirect_to root_path, alert: "You are not authorized to access this page."
            end
        end
    end
end
