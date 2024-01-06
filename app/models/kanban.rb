class Kanban < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  has_many :kanban_columns
end
