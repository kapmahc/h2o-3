class Vote < ApplicationRecord
  validates :resource_type, :resource_id, presence: true
end
