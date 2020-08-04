class ItemsController < ApplicationController
  def index
    @items = Item.new
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
    @item = Item.create(item_params)
  end

  def show
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end


  private

  def item_params
    params.require(:item).permit(:name, :introduction, :condition, :postage_user, :price, :preparation, :prefecture_id, :brand,images_attributes:[:image]).merge(seller_id: current_user.id)
  end

end
