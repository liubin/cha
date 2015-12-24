class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn, :null => false, :limit => 13
      t.string :title, :null => false, :limit => 512
      t.string :subtitle, :limit => 512
      t.string :image, :limit => 256
      t.string :author, :null => false, :limit => 256
      t.string :translator, :limit => 256
      t.integer :pages, :null => false
      t.string :douban_url, :limit => 256
      t.string :jd_url, :limit => 256
      t.string :publisher, :limit => 256
      t.string :author_intro, :limit => 2048
      t.text :summary
      t.decimal :price, :precision => 9, :scale => 2
      t.integer :stocks, :null => false, :default => 0

      t.timestamps null: false
    end

    add_index :books, :isbn, :unique => true
  end
end
