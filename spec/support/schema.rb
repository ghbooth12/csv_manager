ActiveRecord::Schema.define do
  self.verbose = false

  create_table :products, :force => true do |t|
    t.string :name
    t.string :category
    t.integer :quantity
    t.timestamps
  end
end
