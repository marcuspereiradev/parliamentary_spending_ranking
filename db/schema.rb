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

ActiveRecord::Schema.define(version: 2021_02_26_174025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deputies", force: :cascade do |t|
    t.string "ideCadastro"
    t.string "txNomeParlamentar"
    t.string "sgUF"
    t.string "sgPartido"
    t.string "avatar"
    t.string "avatarCongresso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "spents", force: :cascade do |t|
    t.bigint "deputy_id", null: false
    t.float "vlrLiquido"
    t.string "txtFornecedor"
    t.string "urlDocumento"
    t.datetime "datEmissao"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deputy_id"], name: "index_spents_on_deputy_id"
  end

  add_foreign_key "spents", "deputies"
end
