class CreateExcelFiles < ActiveRecord::Migration
  def change
    create_table :excel_files do |t|
      t.attachment :file

      t.timestamps null: false
    end
  end
end
