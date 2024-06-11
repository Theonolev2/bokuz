require 'i18n'

class GroceryListsController < ApplicationController

  def index
    I18n.locale = :fr

    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @grocery_list = GroceryItem.where(meal_plan: @meal_plan)
    @grocery_list = @grocery_list.sort_by do |item|
      I18n.transliterate(item.ingredient.name.downcase)
    end
  end

  def create
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    @meal_plan.grocery_items.destroy_all
    # @meal_plan.meals.each do |meal|
    @meal_plan.meals.each do |meal|
      meal.recipe.ingredients.each do |ingredient|
        grocery_ingredient = @meal_plan.grocery_items.where(ingredient: ingredient)
        item_qty = meal.recipe.recipe_ingredients.where(ingredient_id: ingredient.id).first.qty_per_person * meal.nb_people
        if grocery_ingredient.empty?
          grocery_item = GroceryItem.new(ingredient: ingredient, bought: false, qty_to_buy: item_qty)
          @meal_plan.grocery_items << grocery_item
        else
          @meal_plan.grocery_items.where(id: grocery_ingredient.first.id).first.update(qty_to_buy: @meal_plan.grocery_items.where(id: grocery_ingredient.first.id).first.qty_to_buy + item_qty)
        end
      end
    end
    redirect_to meal_plan_grocery_lists_path(@meal_plan)
  end

  def mapping
    @meal_plan = MealPlan.find(current_user.meal_plans.last.id)
    @stores = Store.all
    # The `geocoded` scope filters only stores with coordinates
    @markers = @stores.geocoded.map do |store|
      {
        lat: store.latitude,
        lng: store.longitude,
        info_window_html: store.name
      }
    end
  end
end
