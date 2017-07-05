module ApplicationHelper
  def site_info(k)
    Setting["#{locale}.site.#{k}"] || ''
  end
end
