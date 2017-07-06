class Attachment < ApplicationRecord
  validates :title, :content_type, presence: true
  mount_uploader :avatar, AvatarUploader
  belongs_to :user

  def is_picture?
    self.content_type.start_with?('image/')
  end
end
