class Admin::SiteController < ApplicationController
  before_action :require_admin!

  def info
    if request.post?
      params.permit(:title, :sub_title, :keywords, :description, :copyright).each {|k, v| Setting["#{locale}.site.#{k}"] = v}
      flash[:notice] = t 'messages.success'
    end

  end

  def status
  end

  def languages
    if request.post?
      Setting.languages = JSON.parse params.fetch(:languages)
      flash[:notice] = t 'messages.success'
    end
  end

  def nav
    if request.post?
      typ = params.fetch :typ
      loc = params.fetch :loc
      key = "#{locale}.nav.#{loc}"
      obj = JSON.parse params.fetch(:val)
      case typ
        when 'dropdown'
          Setting[key] = obj.map{|it| {'label' => it.fetch('label'), 'items' => it.fetch('items').map{|jt| {'label' => jt.fetch('label'), 'href' => jt.fetch('href')}}}}
        when 'link'
          Setting[key] = obj.map{|it| {'label' => it.fetch('label'), 'href' => it.fetch('href')}}
        else
          head :forbidden
      end
      flash[:notice] = t 'messages.success'
      redirect_to admin_site_nav_path(loc: loc, type: typ)
    end
  end

end
