class RecipesController < ApplicationController

  def index 
    # recipes = Recipe.all 
    # render json: { message: "All recipes", recipes: recipes}
  end

  def create
      recipe = Recipe.new(recipe_params)
      if recipe.save!
          render json: { message: "recipe created successfully", recipe: recipe} 
      else
          render json: { message: "recipe creation failed", recipe: recipe} 
      end
  end

  def add_ingredient
    recipe = Recipe.find_by(name: params[:name])
    recipe = recipe.ingredients.create(ingredient_name: params[:ingredient_name], recipe_id: recipe.id)
    if recipe
        render json: { message: "ingreindent added successfully", recipe: recipe} 
    else
        render json: { message: "ingreindent addition failed", recipe: recipe} 
    end
  end

  def search 
    result = if params[:cuisine].present? && params[:ingredient].present?
      ig = Ingredient.where("ingredient_name LIKE ?", "%#{params[:ingredient]}%").pluck(:recipe_id).compact
      res = Recipe.includes(:ingredients).where("name LIKE ? or instructions LIKE ?",  "%#{params[:cuisine]}%",  "%#{params[:cuisine]}%" )
      res.find(ig)
    elsif params[:cuisine].present?
      Recipe.where("name LIKE ? or instructions LIKE ?", "%#{params[:cuisine]}%", "%#{params[:cuisine]}%")
    elsif params[:ingredient].present?
      ig = Ingredient.where("ingredient_name LIKE ?", "%#{params[:ingredient]}%").pluck(:recipe_id).compact
      Recipe.find(ig)  
    else 
      Recipe.all
    end
    if result.empty?
      render json: { "message": "No result found"}
    else
      render json: {"message": "Result of search !!!", result: result}
    end
  end

  private 
  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :instructions)
  end

end
