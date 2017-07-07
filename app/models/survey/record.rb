class Survey::Record < ApplicationRecord
  validates :client_ip, :value, :survey_form_id, presence: true
end
