class Picture < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :image, :content_type => [ 'image/jpg', 'image/png', 'image/jpeg', 'image/gif' ]
  belongs_to :users
  belongs_to :blogs
  belongs_to :awards
  belongs_to :distributors
  belongs_to :challenges
end
