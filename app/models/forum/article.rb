class Forum::Article < ApplicationRecord
  validates :title, :body, :format, :user_id, presence: true

  has_and_belongs_to_many :forum_tags, :class_name => 'Forum::Tag', foreign_key: 'forum_article_id', association_foreign_key: 'forum_tag_id'
  belongs_to :user
  has_many :forum_comments, :class_name => 'Forum::Comment'
end
