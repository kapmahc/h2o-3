class CreateMallVariants < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_variants do |t|
      t.string :sku, null:false, limit:255
      t.string :state, null:false, limit:16

      t.string :name, null:false, limit:255, index:true
      t.string :format, null:false, limit:12, index:true
      t.text :description, null:false
      t.text :assets
      t.text :fields

      t.monetize :price, null:false
      t.monetize :cost, null:false

      t.belongs_to :mall_product, index: true, null: false
      t.belongs_to :mall_store, index: true, null: false

      t.timestamps
    end
    add_index :mall_variants, [:sku, :mall_store_id], unique: true
  end
end
