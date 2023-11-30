class ItemsController < ApplicationController
  before_action :authenticate_user! && :check_admin, only: [:new, :create, :edit, :update, :destroy, :unarchive]
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
    @join_table_item_cart = JoinTableItemsCart.new
    @items = Item.where(active: true)
  end

  def show
    @item = Item.find(params[:id])
  end

  def add_to_cart
    @item = Item.find(params[:id])

    if current_user.cart == nil
      current_user.cart = Cart.create(user: current_user)
    end

    # Check if the item is already in the cart
    jointableitemscart = JoinTableItemsCart.find_by(cart_id: current_user.cart.id, item_id: @item.id)
    if jointableitemscart != nil
      quantity = jointableitemscart.quantity + 1
      jointableitemscart.update(quantity: quantity)
      flash[:notice] = 'Article ajouté au panier. Quantité : ' + quantity.to_s
      redirect_back(fallback_location: item_path(@item))
    else
      @join_table_item_cart = JoinTableItemsCart.new(item_id: @item.id, cart_id: current_user.cart.id, quantity: 1)

      if @join_table_item_cart.save
        flash[:notice] = 'Article ajouté au panier.'
        redirect_back(fallback_location: item_path(@item))
      else
        render :show
      end
    end
  end

  def remove_from_cart
    @cartitem = current_user.cart.join_table_items_carts.find(params[:id])

    @cartitem.destroy
    redirect_to current_user.cart, notice: 'Article retiré du panier.'
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'Produit modifié !'
      redirect_back(fallback_location: item_path(@item))
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.active = false
    @item.save
    redirect_back(fallback_location: root_path)
  end

  def unarchive
    @item = Item.find(params[:id])
    @item.active = true
    @item.save
    redirect_back(fallback_location: root_path)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :tag, :image)
  end

  def permit_link_params
    params.require(:join_table_items_cart).permit(:item_id, :cart_id, :quantity)
  end
  
  def check_admin
    if current_user && current_user.admin?
      # User is authenticated and is an admin
    else
      redirect_to root_path, alert: "Vous avez dû vous perdre."
    end
  end
end
