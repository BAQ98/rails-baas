class CardComment < ApplicationRecord
  belongs_to :card
  belongs_to :auth
end
