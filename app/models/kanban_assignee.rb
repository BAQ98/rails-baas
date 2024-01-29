class KanbanAssignee < ApplicationRecord
  belongs_to :kanban
  belongs_to :profile

  def self.add_assignees(kanban_id, profiles)
    profiles.each do |profile|
      KanbanAssignee.create(
        kanban_id: kanban_id,
        profile_id: profile.id
      )
    end
  end

end
