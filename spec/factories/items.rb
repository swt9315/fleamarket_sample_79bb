FactoryBot.define do
  factory :item do
    name                  {"abe"}
    price                 {1000}
    #category_id              {3}
    introduction          {"setsumei-bun"}
    brand                 {"comoli"}
    condition             {1}
    postage_user          {1}
    prefecture_id         {23}
    preparation           {1}
    seller                {1}
    after(:build) do |product|
      product.images << build(:image, item: item) 
    end
  end
end



