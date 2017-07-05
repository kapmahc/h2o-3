class CreateSurveryFields < ActiveRecord::Migration[5.1]
  def change
    create_table :survery_fields do |t|
      t.string :name, null: false, index: true, limit: 16
      t.string :label, null: false, limit: 255
      t.string :value, limit: 255
      t.string :help, limit: 800
      t.text :options
      t.belongs_to :survery_form, index: true, null: false
      t.timestamps
    end
  end
end
