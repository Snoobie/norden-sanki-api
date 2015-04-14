class ExcelFile < ActiveRecord::Base
  has_attached_file :file
  validates_attachment_content_type :file, :content_type => [ 'application/vnd.ms-excel', 'application/excel' ]
end
