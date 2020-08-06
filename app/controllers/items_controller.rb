class ItemsController < ApplicationController
  def index
  end

  def new
    if user_signed_in?
      @item=Item.new
      @item.images.new
    else
      redirect_to new_user_session_path
    end
  end

  def create
    if  @item=Item.create!(item_params)
    else
      render :index
    end
  end

  def show
    Item.find(params[:id])
    @item = Item.find(params[:id])
  end

 

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
  end



  private

  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :postage_user, :price, :preparation, :prefecture_id, :brand,images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

end
