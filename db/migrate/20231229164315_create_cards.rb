class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :title
      t.string :content
      t.integer :position
      t.references :kanban_column, null: false, foreign_key: true

      t.timestamps
    end
  end
end
