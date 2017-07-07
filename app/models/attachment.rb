class Attachment < ApplicationRecord
  validates :title, :content_type, presence: true
  mount_uploader :avatar, AvatarUploader
  belongs_to :user

  def read(file)
    self.title = file.original_filename
    self.content_type =file.content_type
    self.avatar = file
  end

  def is_picture?
    self.content_type.start_with?('image/')
  end
end
