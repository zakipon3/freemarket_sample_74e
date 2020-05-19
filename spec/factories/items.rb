FactoryBot.define do

  factory :item do
    name                   {"タケオキクチ 7分袖シャツ"}
    price                  {12000}
    explanation            {"7分袖なので、春夏秋で着用できます！"}
    category_id            {23}
    size                   {"M"}
    brand_name             {"タケオキクチ"}
    condition_id           {1}
    delivery_fee_id        {1}
    prefecture_id          {1}
    days_until_shipping_id {1}
    status_id              {1}
    association :category, factory: :category
    after(:build) do |item|
      item.images << build(:image, item: item)
    end
  end

  factory :item_no_image, class: Item do
    name                   {"タケオキクチ 7分袖シャツ"}
    price                  {12000}
    explanation            {"7分袖なので、春夏秋で着用できます！"}
    category_id            {23}
    size                   {"M"}
    brand_name             {"タケオキクチ"}
    condition_id           {1}
    delivery_fee_id        {1}
    prefecture_id          {1}
    days_until_shipping_id {1}
    status_id              {1}
  end
end