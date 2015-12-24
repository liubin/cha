class CreateLendings < ActiveRecord::Migration
  def change
    create_table :lendings do |t|
      t.integer :book_id
      t.integer :user_id
      t.datetime :lent_at
      t.datetime :returned_at

      t.timestamps null: false
    end
  end
end
