class Survey::Form < ApplicationRecord
  validates :title, :body, :format, :start_up, :shut_down, presence: true
  has_many :survey_fields, :class_name => 'Survey::Field', foreign_key: 'survey_form_id'
  has_many :survey_records, :class_name => 'Survey::Record', foreign_key: 'survey_form_id'
end
