FactoryBot.define do

  factory :user do
    name                  {"あべ"}
    email                 {"kkk@gmail.com"}
    password              {"00000000"}
    password_confirmation {"00000000"}
    family_name           {"安倍"}
    first_name            {"一郎"}
    family_name_kana      {"アベ"}
    first_name_kana       {"イチロウ"}
    birthday_year         {"1990"}
    birthday_month        {"1"}
    birthday_day          {"1"}
    user_image            {""}
    introduction          {""}
  end

  factory :address do
    post_code             {"123-4567"}
    prefecture_id         {"111"}
    city                  {"札幌市"}
    house_number          {"札幌町"}
    building_name         {"札幌ビル１０１"}
    phone_number          {"09012345678"}
    user_id               {"1"}
  end

end