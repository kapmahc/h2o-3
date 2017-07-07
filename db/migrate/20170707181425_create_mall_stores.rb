class CreateMallStores < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_stores do |t|
      t.string :name, null:false, limit:255, index:true
      t.string :format, null:false, limit:12, index:true
      t.string :currency, null:false, limit:3, index:true
      t.text :description, null:false
      t.text :contact, null:false
      t.text :assets

      t.timestamps
    end
  end
end
