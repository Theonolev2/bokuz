class MealsController < ApplicationController
  before_action :set_meal, only: [:destroy, :update, :replace, :show]
  before_action :set_meal_plan, only: [:destroy, :update, :replace]

  def show
  end

  def replace
    if @meal_plan.preferences["diets_ids"].nil?
      @recipe = Recipe.where.not(id: @meal_plan.recipes.ids).sample
    else
      forbidden_recipe_ids = Recipe.joins(:diets).where(diets: { id: @meal_plan.preferences["diets_ids"] }).distinct.ids
      filtered_recipes = Recipe.where.not(id: forbidden_recipe_ids)
      @recipe = filtered_recipes.where.not(id: @meal_plan.recipes.ids).sample
    end

    if @recipe.nil?
      flash[:alert] = "You have already seen all meals"
      @recipe = filtered_recipes.where.not(id: @meal.recipe_id).sample
    else
      @meal.update(recipe: @recipe)
      flash[:notice] = "Meal replaced"
    end
    redirect_to meal_plan_path(@meal_plan), status: :see_other
  end

  def update
    @meal.update(meal_params)
    respond_to do |format|
      format.html { redirect_to meal_plan_path(@meal_plan), status: :see_other }
      format.json { render json: @meal }
    end
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
