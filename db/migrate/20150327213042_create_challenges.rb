class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :limit_date
      t.integer :award_id
      t.text :description
      t.integer :picture_id
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
