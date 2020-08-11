class CardController < ApplicationController

  require "payjp"

  def new
     card = Card.where(user_id: current_user.id)
     redirect_to card_show_path(current_user.id) if card.exists?
  end

  def create
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    if params["payjp_token"].blank?
      redirect_to action: "new", alert: "クレジットカードを登録できませんでした。"
    else
      # 生成したトークンから、顧客情報と紐付け、PAY.JP管理サイトに登録
      customer = Payjp::Customer.create(
        # email: current_user.email,
        card: params["payjp_token"],
        metadata: {user_id: current_user.id}
      )
      # 今度はトークン化した情報を自アプリのcardテーブルに登録！
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        #もしcreateビューを作成しない場合はredirect_toなどで表示ビューを指定
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id) # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      @customer_card = customer.cards.retrieve(@card.card_id) # カスタマー情報からカードの情報を引き出す

      # @card_brand = @customer_card.brand # カードのアイコン表示のための定義づけ
      # case @card_brand
      # when "Visa"
      #   # 例えば、Pay.jpからとってきたカード情報の、ブランドが"Visa"だった場合は返り値として
      #   # (画像として登録されている)Visa.pngを返す
      #   @card_src = "visa.png"
      # when "JCB"
      #   @card_src = "jcb.png"
      # when "MasterCard"
      #   @card_src = "master.png"
      # when "American Express"
      #   @card_src = "amex.png"
      # when "Diners Club"
      #   @card_src = "diners.png"
      # when "Discover"
      #   @card_src = "discover.png"
      # end

      @exp_month = @customer_card.exp_month.to_s # 有効期限'月'を定義
      @exp_year = @customer_card.exp_year.to_s.slice(2,3) # 有効期限'年'を定義
    end
  end

  def destroy
    @card = Card.find_by(user_id: current_user.id)
    if @card.blank?
      redirect_to action: "new"
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id) # ログインユーザーのクレジットカード情報からPay.jpに登録されているカスタマー情報を引き出す
      customer.delete # そのカスタマー情報を消す
      @card.delete 
      if @card.destroy # 削除が完了しているか判断
        redirect_to user_path(current_user.id), alert: "削除しました。"
      else
        redirect_to card_show_path(current_user.id), alert: "削除できませんでした。" 
      end
    end
  end

end