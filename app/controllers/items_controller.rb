class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def show
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item=Item.new(item_params)
    if @item.save
    else
      render :new
    end
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end
    
  def edit
  end
  
  def update
  if @item.update(item_params)
    else
      render :edit
    end
  end
 
  private

  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :postage_user, :price, :preparation, :prefecture_id, :brand,images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end