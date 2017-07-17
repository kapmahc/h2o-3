class Mall::Store < ApplicationRecord
  resourcify
  validates :name, :format, :description,:currency, :contact, presence: true
  serialize :contact, JSON
  serialize
end
