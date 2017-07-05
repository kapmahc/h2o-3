class Forum::Tag < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_and_belongs_to_many :forum_articles, :class_name => 'Forum::Article'
end
