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

ActiveRecord::Schema.define(version: 20140621045542) do

  create_table "challenges", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "challenges", ["user_id"], name: "index_challenges_on_user_id"

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

  create_table "feeds", force: true do |t|
    t.string   "model_name"
    t.integer  "model_id"
    t.integer  "user_id"
    t.integer  "wo_set_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["user_id"], name: "index_feeds_on_user_id"
  add_index "feeds", ["wo_set_id"], name: "index_feeds_on_wo_set_id"

  create_table "goals", force: true do |t|
    t.integer  "exercise_id"
    t.integer  "user_id"
    t.string   "weight"
    t.string   "distance"
    t.string   "time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete"
  end

  add_index "goals", ["exercise_id"], name: "index_goals_on_exercise_id"
  add_index "goals", ["user_id"], name: "index_goals_on_user_id"

  create_table "posts", force: true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id", "created_at"], name: "index_posts_on_user_id_and_created_at"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

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
    t.datetime "age"
    t.boolean  "admin",                  default: false
    t.string   "measurement_system"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

  create_table "wo_sets", force: true do |t|
    t.integer  "workout_id"
    t.integer  "exercise_id"
    t.string   "rep"
    t.string   "weight"
    t.string   "time"
    t.string   "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "challenge_id"
  end

  add_index "wo_sets", ["challenge_id"], name: "index_wo_sets_on_challenge_id"
  add_index "wo_sets", ["exercise_id"], name: "index_wo_sets_on_exercise_id"
  add_index "wo_sets", ["workout_id"], name: "index_wo_sets_on_workout_id"

  create_table "workouts", force: true do |t|
    t.integer  "user_id"
    t.integer  "wo_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id"
  add_index "workouts", ["wo_set_id"], name: "index_workouts_on_wo_set_id"

end
