class Video < ActiveRecord::Base
  mount_uploader :attachment, VideoUploader # Tells rails to use this uploader for this model.
  validates :name, presence: true # Make sure the owner's name is present.
  belongs_to :users
  belongs_to :blogs
  belongs_to :challenges
end
