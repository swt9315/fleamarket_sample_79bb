require 'rails_helper'

describe User do
  describe '#create' do
    it "is invalid without a name" do #設定したバリデーションが
      user = build(:user)
      expect(user).to be_valid
    end
  end
  
  it "is invalid with a duplicate email address" do
  user = create(:user)
    #先に登録したユーザーと同じemailの値を持つユーザーのインスタンスを作成
    another_user = build(:user, email: user.email)
    another_user.valid?
    expect(another_user.errors[:email]).to include("has already been taken")
  end

  it "is invalid without a name" do
    user = build(:user, name: "")
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  it "is invalid without an email" do
    user = build(:user, email: "")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
end
