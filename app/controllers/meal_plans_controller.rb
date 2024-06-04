class MealPlansController < ApplicationController
  def show
    @meals = MealPlan.find(params[:id]).meals
  end

  def new
  end

  def create
  end
end
