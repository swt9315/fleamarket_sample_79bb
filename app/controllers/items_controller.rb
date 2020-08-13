class ItemsController < ApplicationController
  before_action :set_parents, only: [:new, :create, :category, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :buy, :pay]
  before_action :set_items, only: [:show, :index]
  before_action :set_images, only: [:buy, :pay]

  require "payjp"

  def index
  end

  def show
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
    @item = Item.new(item_params)
    if @item.save
    else
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

  def buy
    if user_signed_in?
      @user = current_user
      if @user.card.present?
        Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
        @card = Card.find_by(user_id: current_user.id)
        customer = Payjp::Customer.retrieve(@card.customer_id)
        @customer_card = customer.cards.retrieve(@card.card_id)

        # ##カードのアイコン表示のための定義づけ
        # @card_brand = @customer_card.brand
        # case @card_brand
        # when "Visa"
        #   # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
        #   # (画像として登録されている)Visa.pngを返す
        #   @card_src = "visa.gif"
        # when "JCB"
        #   @card_src = "jcb.gif"
        # when "MasterCard"
        #   @card_src = "master.png"
        # when "American Express"
        #   @card_src = "amex.gif"
        # when "Diners Club"
        #   @card_src = "diners.gif"
        # when "Discover"
        #   @card_src = "discover.gif"
        # end
        # viewの記述を簡略化
        ## 有効期限'月'を定義
        @exp_month = @customer_card.exp_month.to_s
        ## 有効期限'年'を定義
        @exp_year = @customer_card.exp_year.to_s.slice(2,3)
      else
      end
    else
      redirect_to user_session_path, alert: "ログインしてください"
    end
  end

  def pay
    # if @product.purchase.present? # (２重で決済されることを防ぐ)
    #   redirect_to item_path(@item.id), alert: "売り切れています。"
    # else
      @item.with_lock do # 同時に2人が同時に購入し、二重で購入処理がされることを防ぐための記述
        if current_user.card.present?
          @card = Card.find_by(user_id: current_user.id)
          Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
          charge = Payjp::Charge.create(
          amount: @item.price,
          customer: Payjp::Customer.retrieve(@card.customer_id),
          currency: 'jpy'
          )
        else
          # ログインユーザーがクレジットカード登録されていない場合(Checkout機能による処理を行います)
          # APIの「Checkout」ライブラリによる決済処理の記述
          Payjp::Charge.create(
          amount: @item.price,
          card: params['payjp-token'],
          )
        end
      @item.update(buyer_id: current_user.id)
      end
    # end
  end
 
  private

  def item_params
    params.require(:item).permit(:name, :introduction, :category_id, :condition, :postage_user, :price, :preparation, :prefecture_id, :brand,images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_images
    @images = @item.images.all
  end

  def set_items
    @items = @items = Item.includes(:images).order('created_at DESC')
  end

  def set_parents
    @parents = Category.all.order("id ASC").limit(13).where(ancestry: nil)
  end

end
