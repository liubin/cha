class CreateWaitings < ActiveRecord::Migration
  def change
    create_table :waitings do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
