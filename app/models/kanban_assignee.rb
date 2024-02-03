class KanbanAssignee < ApplicationRecord
  belongs_to :kanban
  belongs_to :profile

  # validate :profile_not_already_assigned

  # validate duplicate records
  # def self.create!(assignees)
  #   assignees.each do |assignee|
  #     validate_no_duplicate(assignee)
  #   end
  #
  #   super
  # end
end
