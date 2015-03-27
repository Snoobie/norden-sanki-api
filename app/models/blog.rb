class Blog < ActiveRecord::Base
  has_many :pictures
  has_many :videos
end
