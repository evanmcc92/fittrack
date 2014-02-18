# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140218195713) do

  create_table "exercises", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "image"
    t.string   "category"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "exercises", ["user_id"], name: "index_exercises_on_user_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "weight"
    t.string   "height"
    t.string   "bio"
    t.string   "gender"
    t.string   "age"
    t.boolean  "admin",                  default: false
    t.string   "measurement_system"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "workout_sets", force: true do |t|
    t.integer  "user_id"
    t.integer  "exercise_id"
    t.integer  "workout_id"
    t.string   "rep"
    t.string   "weight"
    t.string   "time"
    t.string   "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_sets", ["exercise_id"], name: "index_workout_sets_on_exercise_id"
  add_index "workout_sets", ["user_id"], name: "index_workout_sets_on_user_id"
  add_index "workout_sets", ["workout_id"], name: "index_workout_sets_on_workout_id"

  create_table "workouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "workoutset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
