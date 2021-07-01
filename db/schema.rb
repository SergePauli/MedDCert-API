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

ActiveRecord::Schema.define(version: 2021_06_03_143226) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "address_prints", force: :cascade do |t|
    t.string "region", null: false
    t.string "district"
    t.string "city"
    t.string "town"
    t.string "street"
    t.string "building"
    t.string "flat"
    t.bigint "address_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_address_prints_on_address_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "state", limit: 2, null: false
    t.string "streetAddressLine", null: false
    t.string "aoGUID", limit: 36
    t.string "houseGUID", limit: 36
    t.string "codeKLADR", limit: 25
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["codeKLADR"], name: "index_addresses_on_codeKLADR"
    t.index ["streetAddressLine"], name: "index_addresses_on_streetAddressLine"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organization_contacts", force: :cascade do |t|
    t.bigint "organization_id"
    t.bigint "contact_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contact_id"], name: "index_organization_contacts_on_contact_id"
    t.index ["organization_id"], name: "index_organization_contacts_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "oid", limit: 36, null: false
    t.string "oldOid", limit: 30, null: false
    t.string "scode", limit: 6
    t.string "nameFull", null: false
    t.string "nameShort", limit: 100
    t.string "inn", limit: 10
    t.string "kpp", limit: 9
    t.string "ogrn", limit: 16
    t.string "po_code", limit: 45
    t.date "createDate"
    t.date "modifyDate"
    t.date "deleteDate"
    t.string "deleteReason"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_organizations_on_address_id"
  end

end
