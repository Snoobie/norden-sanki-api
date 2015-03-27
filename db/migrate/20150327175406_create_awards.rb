class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
      t.text :description
      t.integer :picture_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
