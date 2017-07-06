class Survery::Record < ApplicationRecord
  validates :client_ip, :value, :survery_form_id, presence: true
end
