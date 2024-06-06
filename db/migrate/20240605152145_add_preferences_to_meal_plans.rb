class AddPreferencesToMealPlans < ActiveRecord::Migration[7.1]
  def change
    add_column :meal_plans, :preferences, :jsonb, default: {}
  end
end
