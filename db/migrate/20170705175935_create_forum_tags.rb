class CreateForumTags < ActiveRecord::Migration[5.1]
  def change
    create_table :forum_tags do |t|
      t.string :name, limit:255, null: false, unique: true
      t.timestamps
    end

    create_join_table :forum_articles, :forum_tags do |t|
      t.index :forum_article_id
      t.index :forum_tag_id
    end

    add_index :forum_articles_tags, [:forum_article_id, :forum_tag_id], unique: true
  end
end
