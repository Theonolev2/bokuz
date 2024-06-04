class ChangeMealPlanUserId < ActiveRecord::Migration[7.1]
  def change
    change_column_null :meal_plans, :user_id, true
  end
end
