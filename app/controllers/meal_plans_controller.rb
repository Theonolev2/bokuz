class MealPlansController < ApplicationController
  def show
    @meal_plan = MealPlan.find(params[:id])
    @meals = Meal.includes(:meal_plan).where(meal_plan: { id: params[:id] })
  end

  def new
    @meal_plan = MealPlan.new
  end

  def create
    nb_meals = meal_plan_params[:nb_meals].to_i
    nb_people = meal_plan_params[:nb_people].to_i

    @meal_plan = MealPlan.new(user: current_user, name: "Menu du #{Time.now.strftime("%d %B %Y")}")

    forbidden_recipe_ids = Recipe.joins(:diets).where(diets: {id: params[:diets]}).distinct.ids
    filtered_recipes = Recipe.where.not(id: forbidden_recipe_ids)
    filtered_recipes = sampling_and_filling(nb_meals, filtered_recipes)

    @meal_plan.meals = filtered_recipes.map { |recipe| Meal.new(meal_plan: @meal_plan, recipe: recipe, nb_people: nb_people) }

    @meal_plan.preferences = {
      nb_meals: nb_meals,
      nb_people: nb_people,
      diets_ids: params[:diets]}

    if @meal_plan.save
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new, status: 422
    end
  end

  private

  def sampling_and_filling(nb_meals, filtered_recipes)
    if nb_meals <= filtered_recipes.size
      filtered_recipes.sample(nb_meals)
    else
      nb_meals_done = filtered_recipes.size
      while nb_meals_done < nb_meals
        nb = [nb_meals - nb_meals_done, filtered_recipes.size].min
        filtered_recipes += filtered_recipes.sample(nb)
        nb_meals_done += nb
      end
      filtered_recipes
    end
  end

  def meal_plan_params
    params.require(:meal_plan).permit(:name, :user_id, :nb_meals, :nb_people)
  end
end
