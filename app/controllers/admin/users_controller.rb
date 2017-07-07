class Admin::UsersController < ApplicationController
  before_action :require_admin!
  def index
  end

  def apply
    user = User.find params.fetch(:id)
    if user.is_root?
      flash[:alert] = t 'messages.not_allow'
    else
      user = User.find params.fetch(:id)
      user.add_role params.fetch(:role)
      flash[:notice] = t 'messages.success'
    end
    redirect_back fallback_location: root_path
  end

  def deny
    user = User.find params.fetch(:id)
    if user.is_root?
      flash[:alert] = t 'messages.not_allow'
    else
      user.remove_role params.fetch(:role)
      flash[:notice] = t 'messages.success'
    end
    redirect_back fallback_location: root_path
  end
end
