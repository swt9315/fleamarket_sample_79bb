class ItemsController < ApplicationController
  def index
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.create(item_params)
    redirect_to root_path
  end




  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category, :condition, :postage_user, :price, :preparation, :prefecture_id, images_attributes:[:image]).merge(seller_id: current_user.id)
  end

end
