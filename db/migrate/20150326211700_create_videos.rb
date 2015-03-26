class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :filename
      t.string :content_type
      t.binary :data
      t.integer :user_id
      t.text :description

      t.timestamps null: false
    end
  end
end
