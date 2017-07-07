class CreateSurveyFields < ActiveRecord::Migration[5.1]
  def change
    create_table :survey_fields do |t|
      t.string :name, null: false, index: true, limit: 16
      t.string :label, null: false, limit: 255
      t.string :flag, null: false, limit: 12
      t.string :value, limit: 255
      t.string :help, limit: 800
      t.text :options
      t.integer :sort_order, limit:1, null: false
      t.belongs_to :survey_form, index: true, null: false
      t.timestamps
    end
    add_index :survey_fields, [:name, :survey_form_id], unique: true
  end
end
