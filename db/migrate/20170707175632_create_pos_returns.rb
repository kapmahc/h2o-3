class CreatePosReturns < ActiveRecord::Migration[5.1]
  def change
    create_table :pos_returns do |t|
      t.text :flag, null:false, limit:16, index:true

      t.text :items, null:false
      t.text :description, null:false

      t.monetize :amount, null:false

      t.belongs_to :user, index: true, null: false
      t.belongs_to :pos_order, index: true, null: false
      t.timestamps
    end
  end
end
