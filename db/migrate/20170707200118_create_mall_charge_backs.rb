class CreateMallChargeBacks < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_charge_backs do |t|
      t.string :state, index:true, null:false, limit:16
      t.monetize :amount, null:false

      t.text :description

      t.belongs_to :user, index: true, null: false
      t.belongs_to :mall_return_request, index: true, null: false
      t.timestamps
    end
  end
end
