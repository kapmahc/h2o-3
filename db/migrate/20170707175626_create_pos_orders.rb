class CreatePosOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :pos_orders do |t|
      t.string :serial, null:false, limit:255
      t.text :items, null:false
      t.text :flag, null:false, limit:16, index:true

      t.text :description, null:false

      t.monetize :amount, null:false
      t.monetize :payment, null:false
      t.monetize :charge_back, null:false
      t.monetize :discount, null:false

      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
    add_index :pos_orders, :serial, unique: true
  end
end
