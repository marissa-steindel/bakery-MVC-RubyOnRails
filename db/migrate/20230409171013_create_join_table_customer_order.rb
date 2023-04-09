class CreateJoinTableCustomerOrder < ActiveRecord::Migration[7.0]
  def change
    create_join_table :customers, :orders do |t|
      # t.index [:customer_id, :order_id]
      # t.index [:order_id, :customer_id]
      t.decimal :GST
      t.decimal :PST
      t.decimal :HST
    end
  end
end
