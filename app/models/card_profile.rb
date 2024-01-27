class CardProfile < ApplicationRecord
  belongs_to :card
  belongs_to :profile
  belongs_to :author, class_name: 'Profile'
  belongs_to :assignee, class_name: 'Profile'
end