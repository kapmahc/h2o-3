class CreateMallReturnRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :mall_return_requests do |t|
      t.string :state, index:true, null:false, limit:16

      t.text :reason, null:false
      t.text :items, null:false

      t.belongs_to :mall_order, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
  end
end
