class Card < ApplicationRecord
  validates :title, presence: true
  belongs_to :kanban_column
  has_many :card_comments
end

