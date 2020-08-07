require 'rails_helper'
    #空だと登録できないこと
  describe Item do
    it "is invalid without a name" do
      item = Item.new(name: nil)
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end
    it "is invalid without a price" do
      item = Item.new(price: nil)
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end
    it "is invalid without an introduction" do
      item = Item.new(introduction: nil)
      item.valid?
      expect(item.errors[:introduction]).to include("can't be blank")
    end
    it "is invalid without an condition" do
      item = Item.new(condition: nil)
      item.valid?
      expect(item.errors[:condition]).to include("can't be blank")
    end
    it "is invalid without an postage_user" do
      item = Item.new(introduction: nil)
      item.valid?
      expect(item.errors[:postage_user]).to include("can't be blank")
    end
    it "is invalid without an prefecture_id" do
      item = Item.new(prefecture_id: nil)
      item.valid?
      expect(item.errors[:prefecture_id]).to include("can't be blank")
    end
    it "is invalid without an preparation" do
      item = Item.new(preparation: nil)
      item.valid?
      expect(item.errors[:preparation]).to include("can't be blank")
    end

    #名前が41文字以上だと登録されない
    it "is invalid with a name that has more than 40 characters " do
      item = Item.new(name: "a"*41)
      item.valid?
      expect(item.errors[:name]).to include("is too long (maximum is 40 characters)")
    end
    #説明文が1001文字以上だと登録されない
    it "is invalid with a introduction that has more than 1000 characters " do
      item = Item.new(introduction: "a"*1001)
      item.valid?
      expect(item.errors[:introduction]).to include("is too long (maximum is 1000 characters)")
    end
    #金額が10000000円以上だと登録されない
    it "is invalid with a price that has more than 9999999 integer " do
      item = Item.new(price: 100000000)
      item.valid?
      expect(item.errors[:price]).to include("must be less than or equal to 9999999")
    end
     #金額が299円以下だと登録されない
    it "is invalid with a price that has less than 300 integer " do
      item = Item.new(price: 299)
      item.valid?
      expect(item.errors[:price]).to include("must be greater than or equal to 300")
    end
  end


  #必須項目全て入力されていれば登録ができること
  describe Item do
    describe '#create' do
      it "is valid with a name, introduction, price, condition,postage_user,prefecture_id,preparation" do
        item = Item.new(brand:nil)
        expect(item).to be_invalid
      end
    end
  end