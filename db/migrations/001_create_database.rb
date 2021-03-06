class CreateDatabase < ActiveRecord::Migration

  def self.up
    enable_extension "plpgsql"

    create_table "books", primary_key: "isbn13", force: :cascade do |t|
      t.text    "title"
      t.text    "format"
      t.text    "publisher"
      t.integer "year_of_publication"
      t.integer "copies"
      t.text    "keywords"
      t.text    "subject"
      t.decimal "price"
      t.text    "authors"
    end

    create_table "customers", force: :cascade do |t|
      t.text    "name"
      t.integer "mobile"
      t.text    "address"
      t.text    "cc_no"
    end

    create_table "order_items", id: false, force: :cascade do |t|
      t.integer "order_id", null: false
      t.text    "book_id",  null: false
      t.integer "copies",   null: false
    end

    create_table "orders", force: :cascade do |t|
      t.integer "customer_id", null: false
      t.date    "order_date"
      t.text    "status"
    end

    create_table "review_ratings", id: false, force: :cascade do |t|
      t.integer "customer_id",  null: false
      t.text    "book_id",      null: false
      t.integer "customer_id2", null: false
      t.integer "rating"
    end

    create_table "reviews", id: false, force: :cascade do |t|
      t.integer "customer_id", null: false
      t.text    "book_id",     null: false
      t.integer "score",       null: false
      t.date    "review_date"
      t.text    "comment"
      t.decimal "usefulness"
    end

    create_table "store_managers", force: :cascade do |t|
      t.text "name"
    end

    create_table "users", force: :cascade do |t|
      t.text "login_id"
      t.text "password_digest", null: false
    end

    add_index "users", ["login_id"], name: "users_login_id_key", unique: true, using: :btree

    add_foreign_key "customers", "users", column: "id", name: "customers_id_fkey", on_delete: :cascade
    add_foreign_key "order_items", "books", primary_key: "isbn13", name: "order_items_book_id_fkey"
    add_foreign_key "order_items", "orders", name: "order_items_order_id_fkey"
    add_foreign_key "orders", "customers", name: "orders_customer_id_fkey", on_delete: :cascade
    add_foreign_key "review_ratings", "customers", name: "review_ratings_customer_id_fkey"
    add_foreign_key "review_ratings", "reviews", column: "customer_id2", primary_key: "customer_id", name: "review_ratings_customer_id2_fkey"
    add_foreign_key "reviews", "books", primary_key: "isbn13", name: "reviews_book_id_fkey"
    add_foreign_key "reviews", "customers", name: "reviews_customer_id_fkey"
    add_foreign_key "store_managers", "users", column: "id", name: "store_managers_id_fkey", on_delete: :cascade
  end

  def self.down
  end
  
end
