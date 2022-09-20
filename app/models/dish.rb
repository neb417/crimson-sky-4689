class Dish < ApplicationRecord
  validates_presence_of :name, :description
  belongs_to :chef
  has_many :dish_ingredients
  has_many :ingredients, through: :dish_ingredients

  def self.dish_ingredients
    joins(:ingredients)
      .select('ingredients.name')
  end

  def self.top_ingredients
    # binding.pry
    joins(:ingredients)
      .select('dishes.*, count(ingredient.id) AS count')
      .group(:id)
      .order(count: :desc)
      .limit(3)
  end
end