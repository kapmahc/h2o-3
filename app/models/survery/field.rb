class Survery::Field < ApplicationRecord
  validates :name, :label, :flag, :survery_form_id, presence: true
end
