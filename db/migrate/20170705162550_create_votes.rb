class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.string :resource_type, null:false, index: true, limit: 255
      t.integer :resource_id, null:false
      t.timestamps
    end
    add_index :votes, [:resource_type, :resource_id], unique: true
  end
end
