class CreateMallProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_products do |t|
      t.string :name, null:false, limit:255, index:true
      t.string :format, null:false, limit:12, index:true
      t.text :description, null:false
      t.text :contact, null:false
      t.text :assets
      t.text :fields

      t.belongs_to :mall_store, index: true, null: false
      t.belongs_to :mall_vendor, index: true, null: false

      t.timestamps
    end
  end
end
