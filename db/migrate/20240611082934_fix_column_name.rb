class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :stores, :adress, :address
  end
end
