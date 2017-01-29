class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :search
  def require_is_admin
    if !current_user.admin?
      redirect_to root_path, alert: "You have no permission."
    end
  end
  def search
    @q = Job.published.ransack(params[:q])
    @jobs = @q.result(distinct: true)
  end
end
