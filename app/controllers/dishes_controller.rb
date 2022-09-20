class DishesController < ApplicationController
  def show
    @dish = Dish.find(params[:id])
    @total_calories = @dish.ingredients.total_calories
  end
end