class Trade < ApplicationRecord
  belong_to :item
  belong_to :user
end
