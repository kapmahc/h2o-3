class CreateSurveryRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :survery_records do |t|
      t.inet :client_ip, null: false
      t.text :value, null: false
      t.belongs_to :survery_form, index: true, null: false
      t.belongs_to :survery_field, index: true, null: false
      t.timestamps
    end
  end
end
