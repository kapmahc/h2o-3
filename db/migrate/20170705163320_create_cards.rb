class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :loc, index:true, null:false, limit:16
      t.string :title, null:false, limit:255
      t.string :summary, null:false, limit:800
      t.string :href, null:false, limit:255
      t.string :logo, null:false, limit:255
      t.string :action, null:false, limit:32
      t.integer :sort_order, null:false, default: 0, limit: 1
      t.timestamps
    end
  end
end
