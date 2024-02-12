class CreateCardComments < ActiveRecord::Migration[7.1]
  def change
    create_table :card_comments do |t|
      t.string :text
      t.references :card, null: false, foreign_key: true
      t.references :auth, null: false, foreign_key: true

      t.timestamps
    end
  end
end
