class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
    @top_ingredients = @chef.dishes.top_ingredients
  end
end