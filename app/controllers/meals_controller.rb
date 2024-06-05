class MealsController < ApplicationController
  before_action :set_meal, only: [:destroy]
  before_action :set_meal_plan, only: [:destroy]

  def show
  end

  def update
  end

  def destroy
    @meal.destroy
    redirect_to meal_plan_path(@meal_plan), status: :see_other
  end

  private

  def set_meal
    @meal = Meal.find(params[:id])
  end

  def set_meal_plan
    @meal_plan = MealPlan.find(Meal.find(params[:id]).meal_plan_id)
  end
end
