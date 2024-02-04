class KanbanAssignee < ApplicationRecord
  belongs_to :kanban
  belongs_to :profile

  # validate duplicate records
  validates_uniqueness_of :kanban_id, scope: :profile_id
end
