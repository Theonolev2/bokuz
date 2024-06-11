# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_11_094241) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diet_tags", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.bigint "diet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diet_id"], name: "index_diet_tags_on_diet_id"
    t.index ["ingredient_id"], name: "index_diet_tags_on_ingredient_id"
  end

  create_table "diets", force: :cascade do |t|
    t.string "name"
    t.string "icon_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "label"
  end

  create_table "grocery_items", force: :cascade do |t|
    t.float "qty_to_buy"
    t.boolean "bought"
    t.bigint "ingredient_id", null: false
    t.bigint "meal_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_grocery_items_on_ingredient_id"
    t.index ["meal_plan_id"], name: "index_grocery_items_on_meal_plan_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "name"
    t.string "photo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "unit"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "preferences", default: {}
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "meals", force: :cascade do |t|
    t.integer "nb_people"
    t.bigint "recipe_id", null: false
    t.bigint "meal_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_plan_id"], name: "index_meals_on_meal_plan_id"
    t.index ["recipe_id"], name: "index_meals_on_recipe_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.float "qty_per_person"
    t.bigint "recipe_id", null: false
    t.bigint "ingredient_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "photo_url"
    t.integer "prep_time"
    t.string "meal_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "user_diets", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "diet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diet_id"], name: "index_user_diets_on_diet_id"
    t.index ["user_id"], name: "index_user_diets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diet_tags", "diets"
  add_foreign_key "diet_tags", "ingredients"
  add_foreign_key "grocery_items", "ingredients"
  add_foreign_key "grocery_items", "meal_plans"
  add_foreign_key "meal_plans", "users"
  add_foreign_key "meals", "meal_plans"
  add_foreign_key "meals", "recipes"
  add_foreign_key "recipe_ingredients", "ingredients"
  add_foreign_key "recipe_ingredients", "recipes"
  add_foreign_key "user_diets", "diets"
  add_foreign_key "user_diets", "users"
end
