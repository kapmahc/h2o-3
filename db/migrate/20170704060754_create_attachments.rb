class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.string :title, null: false, limit: 255, index: true
      t.string :content_type, null: false, limit: 255, index: true
      t.integer :length, null: false
      t.string :resource_type, null: false, limit: 255, index: true
      t.integer :resource_id, null: false
      t.timestamps
    end
  end
end
