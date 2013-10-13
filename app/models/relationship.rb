class Relationship < ActiveRecord::Base
	belongs_to :sharer, class_name: "User"
	belongs_to :shared, class_name: "User"
	validates :sharer_id, presence: true
  	validates :shared_id, presence: true
end
