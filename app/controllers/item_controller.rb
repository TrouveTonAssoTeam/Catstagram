class ItemController < ApplicationController

    def index
        @items = Item.all
    end

    def show
        @item = Item.find(params[:id]) 
        
    end

    private

      def to_param

      end

end
