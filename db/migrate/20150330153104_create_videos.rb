class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :attachment
      t.integer :user_id
      t.text :description

      t.timestamps null: false
    end
  end
end
