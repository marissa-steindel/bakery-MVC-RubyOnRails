class CreateJoinTableOrderProduct < ActiveRecord::Migration[7.0]
  def change
    create_join_table :orders, :products do |t|
      # t.index [:order_id, :product_id]
      # t.index [:product_id, :order_id]
      t.integer :qty
      t.integer :price
    end
  end
end
