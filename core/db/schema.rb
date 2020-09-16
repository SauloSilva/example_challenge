ActiveRecord::Schema.define(version: 2020_10_15) do
  create_table "accounts", id: :serial, force: :cascade do |t|
    t.string "available_limit"
    t.boolean "active_card"
  end

  create_table "transactions", id: :serial, force: :cascade do |t|
    t.integer "account_id", index: true
    t.string "merchant"
    t.integer "amount"
    t.datetime "time"
  end
end
