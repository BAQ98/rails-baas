class AddProfileToKanbans < ActiveRecord::Migration[7.1]
  def change
    add_reference :kanbans, :profile, null: true, foreign_key: true
  end
end
