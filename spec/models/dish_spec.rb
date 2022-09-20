require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  before(:each) do
    @chef1 = Chef.create!(name: "Chef")
    @chef2 = Chef.create!(name: "Other Chef")

    @dish1 = @chef1.dishes.create!(name: "Pizza", description: "Cheezy Yum")
    @dish2 = @chef1.dishes.create!(name: "Chicken Parm", description: "Fried Yum")

    @ingredient1 = Ingredient.create!(name: "Bread", calories: 100)
    @ingredient2 = Ingredient.create!(name: "Sauce", calories: 80)
    @ingredient3 = Ingredient.create!(name: "Cheese", calories: 120)
    @ingredient4 = Ingredient.create!(name: "Chicken", calories: 150)
    @ingredient5 = Ingredient.create!(name: "Kale", calories: 150)
    @ingredient6 = Ingredient.create!(name: "Tofu", calories: 150)

    @dish1.ingredients << @ingredient1 << @ingredient2 << @ingredient3
    @dish2.ingredients << @ingredient1 << @ingredient2 << @ingredient3 << @ingredient4
  end

  describe 'dish class methods' do
    it'can display ingredient names' do
      names = @dish1.dish_ingredients.map do |ingredient|
                Ingredient.find(ingredient.ingredient_id).name
              end

      expect(names).to eq([@ingredient1.name, @ingredient2.name,@ingredient3.name])
    end
  end
end