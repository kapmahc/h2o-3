class CreateMallOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_orders do |t|
      t.string :serial, null:false, limit:255

      t.string :state, index:true, null:false, limit:16
      t.string :shipment_state, index:true, null:false, limit:16
      t.string :payment_state, index:true, null:false, limit:16

      t.monetize :total, null:false
      t.monetize :items_total, null:false
      t.monetize :adjustment_total, null:false
      t.text :items, null:false

      t.string :address, index: true, null: false
      t.datetime :completed_at

      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
    add_index :mall_orders, :serial, unique: true
  end
end
