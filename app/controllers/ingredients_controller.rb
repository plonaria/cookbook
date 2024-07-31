class IngredientsController < ApplicationController

    def index 
        ingredients = Ingredient.all 
        render json: {message: "Ingredient listing", ingredients: ingredients}
    end

    def create 
        ingredient = Ingredient.new(ingredient_name: params[:ingredient_name])
        if ingredient.save!
            render json: {message: "ingredient created", ingredient: ingredient}
        else 
            render json: {message: "ingredient creation failed", ingredient: ingredient}
        end
    end


end
