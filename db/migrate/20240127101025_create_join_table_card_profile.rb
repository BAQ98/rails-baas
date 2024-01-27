class CreateJoinTableCardProfile < ActiveRecord::Migration[7.1]
  def change
    create_join_table :cards, :profiles do |t|
      t.index [:card_id, :profile_id]
      t.integer :author_id
      t.integer :assignee_id
    end
  end
end
