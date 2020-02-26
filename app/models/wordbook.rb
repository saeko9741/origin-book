class Wordbook < ApplicationRecord
	belongs_to :user
	belongs_to :image
	attachment :my_image
end
