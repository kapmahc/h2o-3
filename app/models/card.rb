class Card < ApplicationRecord
  validates :title, :summary, :format, :href, :action, :loc, presence: true
end
