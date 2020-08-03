FactoryBot.define do
  factory :image do
    image {File.open("#{Rails.root}/images/curry.png")}    
  end
end
