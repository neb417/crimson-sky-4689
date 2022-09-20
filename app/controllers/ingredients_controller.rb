class IngredientsController < ApplicationController
  def index
    chef = Chef.find(params[:chef_id])
    @ingredients = chef.dishes.dish_ingredients
  end
end