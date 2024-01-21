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

ActiveRecord::Schema.define(version: 2024_01_21_152732) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "parliamentaries", force: :cascade do |t|
    t.string "tx_nome_parlamentar"
    t.string "ide_cadastro"
    t.string "sg_uf"
    t.string "sg_partido"
    t.string "avatar"
    t.string "avatar_congresso"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "total_spents"
    t.index ["tx_nome_parlamentar"], name: "index_parliamentaries_on_tx_nome_parlamentar"
  end

  create_table "spents", force: :cascade do |t|
    t.string "txt_fornecedor"
    t.datetime "dat_emissao"
    t.float "vlr_liquido"
    t.string "url_documento"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "parliamentary_id"
    t.index ["parliamentary_id"], name: "index_spents_on_parliamentary_id"
  end

end
