require 'rails_helper'

RSpec.describe 'Chef show page' do

  before(:each) do
    @chef1 = Chef.create!(name: "Chef")
    @chef2 = Chef.create!(name: "Other Chef")

    @dish1 = @chef1.dishes.create!(name: "Pizza", description: "Cheezy Yum")
    @dish2 = @chef1.dishes.create!(name: "Chicken Parm", description: "Fried Yum")
    @dish3 = @chef1.dishes.create!(name: "Salad", description: "for Rabbits")
    @dish4 = @chef1.dishes.create!(name: "Something Else", description: "Random message")

    @ingredient1 = Ingredient.create!(name: "Bread", calories: 100)
    @ingredient2 = Ingredient.create!(name: "Sauce", calories: 80)
    @ingredient3 = Ingredient.create!(name: "Cheese", calories: 120)
    @ingredient4 = Ingredient.create!(name: "Chicken", calories: 150)
    @ingredient5 = Ingredient.create!(name: "Kale", calories: 150)
    @ingredient6 = Ingredient.create!(name: "Tofu", calories: 150)
    @ingredient7 = Ingredient.create!(name: "Bacon", calories: 250)
    @ingredient8 = Ingredient.create!(name: "Ranch Dressing", calories: 1500)

    @dish1.ingredients << @ingredient1 << @ingredient2 << @ingredient3
    @dish2.ingredients << @ingredient1 << @ingredient2 << @ingredient3 << @ingredient4
    @dish3.ingredients << @ingredient1 << @ingredient2 << @ingredient3 << @ingredient5
    @dish4.ingredients << @ingredient1 << @ingredient2 << @ingredient3 << @ingredient5 << @ingredient6
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

    it 'click link and taken to chef ingredient index page' do
      visit chef_path(@chef1.id)

      click_link "Ingredients #{@chef1.name} uses"

      expect(current_path).to eq(chef_ingredients_path(@chef1.id))
    end

    it 'click link and taken to chef ingredient index page with listed ingredients' do
      visit chef_path(@chef1.id)

      click_link "Ingredients #{@chef1.name} uses"

      expect(page).to have_content(@ingredient1.name)
      expect(page).to have_content(@ingredient2.name)
      expect(page).to have_content(@ingredient3.name)
      expect(page).to have_content(@ingredient4.name)
      expect(page).to have_content(@ingredient5.name)
      expect(page).to have_content(@ingredient6.name)
      expect(page).to_not have_content(@ingredient7.name)
      expect(page).to_not have_content(@ingredient8.name)
    end

    it 'show the top 3 used ingredients' do
      visit chef_path(@chef1.id)

      within("#top_ingredients") do
        expect(page).to have_content(@ingredient1.name)
        expect(page).to have_content(@ingredient2.name)
        expect(page).to have_content(@ingredient3.name)
        expect(page).to_not have_content(@ingredient4.name)
        expect(page).to_not have_content(@ingredient5.name)
        expect(page).to_not have_content(@ingredient6.name)
      end
    end
  end
end