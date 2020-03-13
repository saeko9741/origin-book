class Wordbook < ApplicationRecord
	belongs_to :user
	belongs_to :image
	attachment :my_image
  validates :meaning, presence: true, length: {maximum: 30, minimum: 2}
  validates :origin, presence: true, length: {maximum: 200, minimum: 2}
end
