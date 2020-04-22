class Wordbook < ApplicationRecord
  belongs_to :user
  belongs_to :image
  attachment :my_image
  validates :meaning, presence: true, length: {maximum: 30, minimum: 1}
  validates :origin, presence: true, length: {maximum: 500, minimum: 2}
end
