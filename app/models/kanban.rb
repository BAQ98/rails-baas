class Kanban < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  belongs_to :author, class_name: 'Profile'
  has_many :kanban_columns, dependent: :destroy
end
