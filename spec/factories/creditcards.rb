FactoryBot.define do

  factory :creditcard do
    card_id            {4242424242424242}
    customer_id         {"112345"}
    user_id             {"134567"}
    user
  end
end