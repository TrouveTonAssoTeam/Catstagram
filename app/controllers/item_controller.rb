class ItemController < ApplicationController

    def index
        @items = Item.all
    end

    def show

    end

    private

      def to_param

      end

end
