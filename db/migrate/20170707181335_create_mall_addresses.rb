class CreateMallAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_addresses do |t|
      t.string :name, index:true, null:false, limit:64
      t.string :phone, index:true, null:false, limit:16
      t.string :zip, index:true, null:false, limit:8

      t.string :street, null:false, limit:255
      t.string :city, index:true, null:false, limit:32
      t.string :state, index:true, null:false, limit:32
      t.string :country, index:true, null:false, limit:32

      t.belongs_to :user, index: true, null: false

      t.timestamps
    end
  end
end
