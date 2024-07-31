class Recipe < ApplicationRecord

  validates :name, presence: true, length: { maximum: 100}
  validates :instructions, presence: true, length: { maximum: 100}
  validates :cooking_time, presence: true,  comparison: { greater_than: 0 }

  has_many :ingredients, dependent: :destroy
end
