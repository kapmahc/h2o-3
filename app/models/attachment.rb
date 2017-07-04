class Attachment < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
end
