class Ingredient < ApplicationRecord

    validates :ingredient_name, presence: true, length: { maximum: 100}

    belongs_to :recipe, foreign_key: :recipe_id, optional: true
end
