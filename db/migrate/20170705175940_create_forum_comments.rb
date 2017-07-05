class CreateForumComments < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_comments do |t|
      t.text :body, null:false
      t.string :format, null: false, limit: 12

      t.belongs_to :forum_article, index: true, null: false
      t.belongs_to :user, index: true, null: false
      t.timestamps
    end
    add_index :forum_comments, :format
  end
end
