class Wordbook < ApplicationRecord
	belongs_to :user
	belongs_to :image
	attachment :profile_image, destroy: false
end
