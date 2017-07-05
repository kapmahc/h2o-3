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

  def languages
    authorize :dashboard, :admin?
    if request.post?
      Setting.languages = JSON.parse params.fetch(:languages)
      flash[:notice] = t 'messages.success'
    end
  end

  def nav
    authorize :dashboard, :admin?
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
