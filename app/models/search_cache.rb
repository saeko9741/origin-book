class SearchCache < ApplicationRecord
  has_many :images
  validates :word, presence: true, length: {in: 2..20}, format: { with: /\A[a-zA-Z]+\z/ }
end