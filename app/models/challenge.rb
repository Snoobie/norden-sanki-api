class Challenge < ActiveRecord::Base
  has_many :pictures
  has_many :awards
  has_many :products
  has_many :videos
end
