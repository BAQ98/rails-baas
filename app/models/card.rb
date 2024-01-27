class Card < ApplicationRecord
  validates :title, presence: true
  belongs_to :kanban_column
  has_many :card_profiles
  has_many :assignees, through: :card_profiles, class_name: 'Profile'
  belongs_to :author, class_name: 'Profile'
end

