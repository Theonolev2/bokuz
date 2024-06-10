class GroceryItemsController < ApplicationController
  def update
  end

  def mark_as_bought
    @grocery_item = GroceryItem.find(params[:id])
    @grocery_item.update(bought: !@grocery_item.bought)

    respond_to do |format|
      format.html { redirect_to meal_plan_grocery_lists_path(@grocery_item.meal_plan) }
      format.json { render json: {
        partial: render_to_string(
          partial: "grocery_lists/item",
          locals: { item: @grocery_item },
          formats: :html
          )
        }
      }
    end
  end

  private

  def grocery_item_params
    params.require(:grocery_item).permit(:name, :quantity, :unit, :bought)
  end
end
