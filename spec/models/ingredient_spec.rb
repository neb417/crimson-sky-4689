require 'rails_helper'

RSpec.describe Ingredient, type: :model do

  describe "relationships" do
    it {should have_many :dish_ingredients}
    it {should have_many(:dishes).through(:dish_ingredients)}
  end

  before(:each) do
    @chef1 = Chef.create!(name: "Chef")

    @dish1 = @chef1.dishes.create!(name: "Pizza", description: "Cheezy Yum")
    @dish2 = @chef1.dishes.create!(name: "Chicken Parm", description: "Fried Yum")

    @ingredient1 = Ingredient.create!(name: "Bread", calories: 100)
    @ingredient2 = Ingredient.create!(name: "Sauce", calories: 80)
    @ingredient3 = Ingredient.create!(name: "Cheese", calories: 120)
    @ingredient4 = Ingredient.create!(name: "Chicken", calories: 150)

    @dish1.ingredients << @ingredient1 << @ingredient2 << @ingredient3
    @dish2.ingredients << @ingredient1 << @ingredient2 << @ingredient3 << @ingredient4
  end

  describe 'class methods' do
    it{expect(@dish1.ingredients.total_calories).to eq(300)}
  end
end