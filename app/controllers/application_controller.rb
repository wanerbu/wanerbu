class ApplicationController < ActionController::Base
  protect_from_forgery

private 
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    # 如果是后台用户退出，那么回到登录画面，如果是前台用户退出，回到首页
    resource_or_scope == :admin ? new_admin_session_path : root_path
  end
end
