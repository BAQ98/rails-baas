class CreateKanbanAssigneesJoinTable < ActiveRecord::Migration[7.1]
  def change
    create_join_table :kanbans, :profiles,
                      table_name: :kanban_assignees do |t|
      t.index [:kanban_id, :profile_id]
      t.timestamps
    end
  end
end
