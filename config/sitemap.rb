# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "#{ENV['SCHEME']}://#{ENV['HOST']}"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  # languages
  Setting.languages.map{|k,_|k}.each do |l|
    add root_path(locale:l)
  end

  add donate_path

  # users
  add new_user_session_path
  add new_user_registration_path
  add new_user_password_path
  add new_user_confirmation_path
  add new_user_unlock_path
  add new_leave_word_path


  # forum
  add latest_forum_tags_path
  add latest_forum_articles_path
  add latest_forum_comments_path
  Forum::Article.find_each do |it|
    add forum_article_path(it), lastmod: it.updated_at
  end
  Forum::Tag.find_each do |it|
    add forum_tag_path(it), lastmod: it.updated_at
  end

  # survery
  Survery::Form.find_each do |it|
    add new_survery_form_record_path(it), lastmod: it.updated_at
  end

end
