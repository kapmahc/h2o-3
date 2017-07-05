module ApplicationHelper
  def site_info(k)
    Setting["#{locale}.site.#{k}"] || ''
  end

  def md2ht(txt)
    Kramdown::Document.new(txt).to_html.html_safe
  end
end
