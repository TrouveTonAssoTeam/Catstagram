class ItemsController < ApplicationController
  before_action :authenticate_user! && :authenticate_admin!, only: [:new, :create, :edit, :update, :destroy, :unarchive]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Photo ajoutée!.'
    else
      render :new
    end
  end

  def index
    @items = Item.where(active: true)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to @item, notice: 'Produit modifié !'
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

  def authenticate_admin!
    if current_user
        if !current_user.admin?
            redirect_to root_path, alert: "Vous vous êtes sûrement perdu."
        end
    end
  end
end