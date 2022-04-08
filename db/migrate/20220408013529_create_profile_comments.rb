class CreateProfileComments < ActiveRecord::Migration[6.1]
  def change
    create_table :profile_comments do |t|
      t.text :comment
      t.references :customer, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
