require 'rails_helper'

RSpec.describe 'Dish show page' do

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

  describe 'Visiting the Dish show page' do
    it 'the dish name and description is displayed' do
      visit dish_path(@dish1.id)

      expect(page).to have_content(@dish1.name)
      expect(page).to have_content(@dish1.description)
      expect(page).to_not have_content(@dish2.description)
      expect(page).to_not have_content(@dish2.description)
    end 
    it 'displayed is a list of dish ingredients' do
      visit dish_path(@dish1.id)

      expect(page).to have_content(@ingredient1.name)
      expect(page).to have_content(@ingredient2.name)
      expect(page).to have_content(@ingredient3.name)
      expect(page).to_not have_content(@ingredient4.name)
    end
  end
end