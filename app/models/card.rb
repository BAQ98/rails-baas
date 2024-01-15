class Card < ApplicationRecord
  validates :title, presence: true
  belongs_to :kanban_column
end

