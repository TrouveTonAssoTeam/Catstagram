class ItemsController < ApplicationController
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Photo ajoutée!'
    else
      render :new
    end
  end

  def index
    @items = Item.all
    @join_table_item_cart = JoinTableItemsCart.new
  end

  def show
    @item = Item.find(params[:id])
    @join_table_item_cart = JoinTableItemsCart.new(item_id: @item.id, cart_id: current_user.cart.id)
  end

  def add_to_cart
    @item = Item.find(params[:id])
    @join_table_item_cart = JoinTableItemsCart.new(item_id: @item.id, cart_id: current_user.cart.id)
    
    if @join_table_item_cart.save
      redirect_to @item, notice: 'Article ajouté au panier.'
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :tag, :image)
  end

  private

  def permit_link_params
    params.require(:join_table_items_cart).permit(:item_id, :cart_id, :quantity)
  end
end
