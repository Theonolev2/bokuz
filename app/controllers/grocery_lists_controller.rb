class GroceryListsController < ApplicationController
  def index
    @grocery_lists = GroceryItem.includes(:meal_plan).where(meal_plan: { id: params[:meal_plan_id] })
  end

  def create
  end

  def mapping
    @variable = "toto"
  end
end
