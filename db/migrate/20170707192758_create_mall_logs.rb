class CreateMallLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_logs do |t|

      t.string :action, index: true, null: false, limit: 255
      t.integer :quantity, null:false

      t.belongs_to :user, index: true, null: false
      t.belongs_to :mall_variant, index: true, null: false
      t.belongs_to :mall_store, index: true, null: false
      t.timestamps
    end

  end
end
