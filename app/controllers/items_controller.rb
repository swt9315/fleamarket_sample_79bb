class ItemsController < ApplicationController
  before_action :set_parents, only: [:new, :create, :category, :show]
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.new
      @category_parent_array = Category.where(ancestry: nil)
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

  def show
  end
    
  def destroy
    unless @item.destroy
      flash.now[:alert] = '商品出品の削除が失敗しました。'
      render :show
    end
  end
    
  def category
  end
  
  def search
    respond_to do |format|
      format.html
      format.json do
        if params[:parent_id]
          @childrens = Category.find(params[:parent_id]).children
        elsif params[:children_id]
          @grandChilds = Category.find(params[:children_id]).children
        end
      end
    end
  end
  
  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
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
    params.require(:item).permit(:name, :introduction, :category_id, :condition, :postage_user, :price, :preparation, :prefecture_id, :brand,images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end
  
  def set_parents
    @parents = Category.all.order("id ASC").limit(13).where(ancestry: nil)
  end
end