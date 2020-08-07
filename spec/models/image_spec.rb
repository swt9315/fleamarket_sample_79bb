require 'rails_helper'
#画像が空だと登録されない
describe Image do
  it "is invalid without an image" do
    image = Image.new(image: nil)
    image.valid?
    expect(image.errors[:image]).to include("can't be blank")
  end
end
