class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :name
      t.integer :member
      t.text :address
      t.text :level
      t.text :activity_day
      t.text :plofile_image
      t.string :category

      t.timestamps
    end
  end
end
