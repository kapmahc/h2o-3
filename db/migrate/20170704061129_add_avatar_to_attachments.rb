class AddAvatarToAttachments < ActiveRecord::Migration[5.1]
  def change
    add_column :attachments, :avatar, :string, null: false
  end
end
