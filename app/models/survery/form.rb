class Survery::Form < ApplicationRecord
  validates :title, :body, :format, :start_up, :shut_down, presence: true
  has_many :survery_fields, :class_name => 'Survery::Field', foreign_key: 'survery_form_id'
  has_many :survery_records, :class_name => 'Survery::Record', foreign_key: 'survery_form_id'
end
