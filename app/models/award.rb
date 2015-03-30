class Award < ActiveRecord::Base
  has_many :pictures
  has_many :users
  belongs_to :challenges
end
