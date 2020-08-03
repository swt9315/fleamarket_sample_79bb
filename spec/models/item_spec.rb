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
    end
 

    describe Item do
      describe '#create' do
        it "is valid with a name, introduction, price, condition,postage_user,prefecture_id,preparation" do
          item = Item.new(brand:nil)
          expect(item).to be_invalid
        end
      end
    end


