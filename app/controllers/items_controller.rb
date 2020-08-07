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
      flash.now[:alert] = '入力に誤りがあります。'
      render :new
    end
  end
    
  def destroy
    @item = Item.find(params[:id])
    if @item.destroy
    else
      flash.now[:alert] = '商品出品の削除が失敗しました。'
      render :show
    end
  end
 
  def edit
  end
  
  def update
  if @item.update(item_params)
    else
      flash.now[:alert] = '入力に誤りがあります。'
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