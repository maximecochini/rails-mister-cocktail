class Review < ApplicationRecord
  belongs_to :cocktail

  validates :content, presence: true
  validates :rating, numericality: { only_integer: true }, inclusion: { in: 0..5 }, presence: true
end
