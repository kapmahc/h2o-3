class DashboardPolicy < Struct.new(:user, :dashboard)
  def admin?
    sign_in? && user.is_admin?
  end

  def sign_in?
    !user.nil?
  end
end
