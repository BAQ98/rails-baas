class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.belongs_to :auth
      t.string :name
      t.string :username
      t.string :position
      t.string :skills, array: true, default: []
      t.timestamps
    end
  end
end
