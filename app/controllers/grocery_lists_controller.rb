class GroceryListsController < ApplicationController
  def index
    @meal_plan = MealPlan.find(params[:meal_plan_id])
    # raise
    @grocery_lists = GroceryItem.includes(:meal_plan).where(meal_plan: { id: params[:meal_plan_id] })
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
    @variable = "toto"
  end
end
