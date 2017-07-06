class CreateSurveryFields < ActiveRecord::Migration[5.1]
  def change
    create_table :survery_fields do |t|
      t.string :name, null: false, index: true, limit: 16
      t.string :label, null: false, limit: 255
      t.string :flag, null: false, limit: 12
      t.string :value, limit: 255
      t.string :help, limit: 800
      t.text :options
      t.integer :sort_order, limit:1, null: false
      t.belongs_to :survery_form, index: true, null: false
      t.timestamps
    end
    add_index :survery_fields, [:name, :survery_form_id], unique: true
  end
end
