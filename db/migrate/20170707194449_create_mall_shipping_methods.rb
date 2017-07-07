class CreateMallShippingMethods < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_shipping_methods do |t|
      t.boolean :active, null:false
      t.string :tracking, limit:255

      t.string :name, null:false, limit:255, index:true
      t.string :format, null:false, limit:12, index:true
      t.text :description, null:false

      t.text :profile, null:false

      t.timestamps
    end
  end
end
