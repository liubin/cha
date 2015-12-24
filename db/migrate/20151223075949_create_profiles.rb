class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :nick
      t.string :first_name
      t.string :last_name
      t.string :slug
      t.attachment :avatar

      t.timestamps null: false
    end
  end
end
