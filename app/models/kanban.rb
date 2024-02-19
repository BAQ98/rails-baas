class Kanban < ApplicationRecord
  validates :name, uniqueness: true, presence: true
  belongs_to :author, class_name: 'Profile'
  has_many :kanban_columns, dependent: :destroy
  has_many :kanban_assignees
  has_many :profiles, through: :kanban_assignees

  after_create :assign_creator

  def assign_creator
    KanbanAssignee.create(
      kanban: self,
      profile: author
    )
  end
end
