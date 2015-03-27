class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.text :description
      t.string :author
      t.integer :picture_id
      t.integer :video_id

      t.timestamps null: false
    end
  end
end
