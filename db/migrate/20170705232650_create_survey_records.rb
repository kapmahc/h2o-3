class CreateSurveyRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :survey_records do |t|
      t.inet :client_ip, null: false
      t.text :value, null: false
      t.belongs_to :survey_form, index: true, null: false
      t.timestamps
    end
  end
end
