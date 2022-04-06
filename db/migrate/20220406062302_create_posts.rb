class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :customer, null: false, foreign_key: true
      t.date :game_on
      t.integer :prefecture
      t.text :ground
      t.text :content

      t.timestamps
    end
  end
end
