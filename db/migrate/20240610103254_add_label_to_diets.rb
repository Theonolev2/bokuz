class AddLabelToDiets < ActiveRecord::Migration[7.1]
  def change
    add_column :diets, :label, :string
  end
end
