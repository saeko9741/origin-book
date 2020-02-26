class Image < ApplicationRecord
	has_many :wordbooks
	belongs_to :search_cache
end
