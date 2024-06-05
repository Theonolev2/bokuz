class MealsController < ApplicationController
  before_action :set_meal, only: [:destroy, :update, :replace]
  before_action :set_meal_plan, only: [:destroy, :update, :replace]

  def show
  end

  def replace
    raise
    if params[:filtered_recipes_ids].nil?
      @recipe = Recipe.where.not(id: @meal_plan.recipes.ids).sample
    else
      @recipe = Recipe.where(id: params[:filtered_recipes_ids]).where.not(id: @meal_plan.recipes.ids).sample
    end

    @meal.update(recipe: @recipe)
    # raise
    redirect_to meal_plan_path(@meal_plan), status: :see_other
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
    @meal_plan = @meal.meal_plan
  end

  def meal_params
    params.require(:meal).permit(:nb_people, :recipe_id, :meal_plan_id)
  end
end
