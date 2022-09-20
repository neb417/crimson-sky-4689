require 'rails_helper'

RSpec.describe 'Chef show page' do

  before(:each) do
    @chef1 = Chef.create!(name: "Chef")
    @chef2 = Chef.create!(name: "Other Chef")

    @dish1 = @chef1.dishes.create!(name: "Pizza", description: "Cheezy Yum")
    @dish2 = @chef1.dishes.create!(name: "Chicken Parm", description: "Fried Yum")

    @ingredient1 = Ingredient.create!(name: "Bread", calories: 100)
    @ingredient2 = Ingredient.create!(name: "Sauce", calories: 80)
    @ingredient3 = Ingredient.create!(name: "Cheese", calories: 120)
    @ingredient4 = Ingredient.create!(name: "Chicken", calories: 150)

    @dish1.ingredients << @ingredient1 << @ingredient2 << @ingredient3
    @dish2.ingredients << @ingredient1 << @ingredient2 << @ingredient3 << @ingredient4
  end

  describe 'Visiting the Chef show page' do
    it 'displays the name of the chef' do
      visit chef_path(@chef1.id)

      expect(page).to have_content(@chef1.name)
      expect(page).to_not have_content(@chef2.name)
    end

    it 'displays a link to view a list of all ingredients that this chef uses in their dishes' do
      visit chef_path(@chef1.id)

      expect(page).to have_link("Ingredients #{@chef1.name} uses")
    end

    it 'click link and taken to chef ingredient show page' do
      visit chef_path(@chef1.id)

      click_link "Ingredients #{@chef1.name} Uses"

      expect(current_path).to eq(chef_ingredients_path(@chef1.id))
    end
  end
end