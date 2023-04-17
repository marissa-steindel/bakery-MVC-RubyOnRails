class CreateOrderProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_products do |t|
      t.references :order, null: true, foreign_key: true
      t.references :product, null: true, foreign_key: true
      t.integer :qty
      t.integer :price

      t.timestamps
    end
  end
end
