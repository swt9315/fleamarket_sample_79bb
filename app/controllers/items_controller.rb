class ItemsController < ApplicationController
  before_action :set_parents, only: [:new, :create, :category]

  def index
    @items = Item.new
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.new
      @category_parent_array = ["---"]
      @category_parent_array = Category.where(ancestry: nil)
    else
      redirect_to new_user_session_path
    end
  end

  def create
    @item = Item.create(item_params)
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    @item.destroy
    redirect_to root_path
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

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :condition, :postage_user, :price, :preparation, :prefecture_id, :brand, images_attributes:[:image]).merge(seller_id: current_user.id)
  end

  def set_parents
    @parents = Category.all.order("id ASC").limit(13).where(ancestry: nil)
  end

end
