class CreateDistributors < ActiveRecord::Migration
  def change
    create_table :distributors do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :state
      t.string :address
      t.decimal :latitud
      t.decimal :longitude
      t.string :phone
      t.string :email
      t.string :website
      t.text :schedule
      t.integer :picture_id

      t.timestamps null: false
    end
  end
end
