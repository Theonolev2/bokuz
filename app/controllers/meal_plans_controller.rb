class MealPlansController < ApplicationController
  def show
  end

  def new
    @meal_plan = MealPlan.new

  end

  def create
    @meal_plan = MealPlan.new
    @meal_plan.user = current_user
    @meal_plan.name = "Menu du #{Time.now.strftime("%d %B %Y")}"
    @meal_plan.recipes = Recipe.all.sample(meal_plan_params[:nb_meals].to_i)

    nb_people = meal_plan_params[:nb_people].to_i
    @meal_plan.recipes.each do |recipe|
      recipe.ingredients.each do |ingredient|
        grocery_item = GroceryItem.new(
          ingredient: ingredient,
          bought: false,
          qty_to_buy: ( nb_people * recipe.recipe_ingredients.find_by(ingredient: ingredient).qty_per_person))
        @meal_plan.grocery_items << grocery_item
      end
    @meal_plan.meals.each { |meal| meal.nb_people = nb_people }
    end

    if @meal_plan.save
      redirect_to meal_plan_path(@meal_plan)
    else
      render :new, status: 422
    end
	end

  private

  def meal_plan_params
    params.require(:meal_plan).permit(:name, :user_id, :nb_meals, :nb_people)
  end
end
