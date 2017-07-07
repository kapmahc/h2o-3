class CreateMallStocks < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_stocks do |t|
      t.integer :quantity, null:false
      t.belongs_to :mall_variant, index: true, null: false
      t.belongs_to :mall_store, index: true, null: false
      t.timestamps
    end

    add_index :mall_stocks, [:mall_store_id, :mall_variant_id], unique:true
  end
end
