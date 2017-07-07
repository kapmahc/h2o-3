class Survey::Field < ApplicationRecord
  validates :name, :label, :flag, :survey_form_id, presence: true
end
