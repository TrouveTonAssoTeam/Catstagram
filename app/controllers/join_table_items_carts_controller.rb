class JoinTableItemsCartsController < ApplicationController

  def create
    permitted_params = join_table_items_cart_params
    @item_add = JoinTableItemsCart.add_or_create_cart_item_link(permitted_params)
    redirect_to items_path
  end

  private

  def join_table_items_cart_params
    params.require(:join_table_items_cart).permit(:item_id, :cart_id, :quantity)
  end

  def update
  end

  def destroy
    @item_delete = JoinTableItemsCart.find(params[:id])
    @item_delete.destroy
    redirect_to cart_path
  end
end
