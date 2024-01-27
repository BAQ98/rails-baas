class Kanban < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  belongs_to :profile
  has_many :kanban_columns, dependent: :destroy
end
