class Forum::Comment < ApplicationRecord
  validates :body, :format, :user_id, :forum_article_id, presence: true

  belongs_to :forum_article, :class_name => 'Forum::Article'
  belongs_to :user
end
