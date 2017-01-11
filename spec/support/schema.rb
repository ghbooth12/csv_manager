ActiveRecord::Schema.define do
  self.verbose = false

  create_table :products, :force => true do |t|
    t.string :name
    t.string :category
    t.integer :quantity
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
