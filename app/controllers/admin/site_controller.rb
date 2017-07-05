class Admin::SiteController < ApplicationController

  def info
    authorize :dashboard, :admin?
    if request.post?
      params.permit(:title, :sub_title, :keywords, :description, :copyright).each {|k, v| Setting["#{locale}.site.#{k}"] = v}
      flash[:notice] = t 'messages.success'
    end

  end

  def status
    authorize :dashboard, :admin?

  end



end
