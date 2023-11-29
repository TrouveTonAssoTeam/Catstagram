class DashboardController < ApplicationController
    def index
        @items = Item.all
    end
end
