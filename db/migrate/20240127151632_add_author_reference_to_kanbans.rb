class AddAuthorReferenceToKanbans < ActiveRecord::Migration[7.1]
  def change
    add_reference :kanbans, :author
    add_foreign_key :kanbans, :profiles, column: :author_id
  end
end
