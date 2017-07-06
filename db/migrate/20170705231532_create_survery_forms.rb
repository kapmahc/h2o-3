class CreateSurveryForms < ActiveRecord::Migration[5.1]
  def change
    create_table :survery_forms do |t|
      t.string :title, null: false, limit: 255
      t.text :body, null: false
      t.string :format, null: false, limit: 12

      t.date :start_up, null: false
      t.date :shut_down, null: false

      t.timestamps
    end
    add_index :survery_forms, :title
    add_index :survery_forms, :format
  end
end
