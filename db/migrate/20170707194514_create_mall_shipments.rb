class CreateMallShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_shipments do |t|
      t.string :state, null:false, index:true, limit:16
      t.monetize :cost, null:false

      t.string :serial, null:false, limit:255
      t.datetime :shipped_at

      t.belongs_to :mall_shipment_method, index: true, null: false
      t.belongs_to :mall_order, index: true, null: false
      t.timestamps
    end
  end
end
