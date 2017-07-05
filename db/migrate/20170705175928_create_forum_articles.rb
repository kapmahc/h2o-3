class CreateForumArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_articles do |t|
      t.string :title, null: false, limit: 255
      t.text :body, null: false
      t.string :format, null: false, limit: 12

      t.belongs_to :user, index: true, null: false
      t.timestamps
    end

    add_index :forum_articles, :title
    add_index :forum_articles, :format

  end
end
