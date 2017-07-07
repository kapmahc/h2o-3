class CreateMallPayments < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_payments do |t|
      t.monetize :amount, null:false
      t.string :state, null:false, index:true, limit:16

      t.string :response_code, index:true, limit:3
      t.text :avs_response

      t.belongs_to :mall_payment_method, index: true, null: false
      t.belongs_to :mall_order, index: true, null: false

      t.timestamps
    end
  end
end
