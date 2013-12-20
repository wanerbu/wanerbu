class ApplicationController < ActionController::Base
  protect_from_forgery

  private 
  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    # 如果是后台用户退出，那么回到登录画面，如果是前台用户退出，回到首页
    resource_or_scope == :admin ? new_admin_session_path : root_path
  end
  #为了在model层取出当前用户的信息
  def set_current_user
    User.current = current_user
  end
  #如果从其他页面登录，回到该页面，如果是直接登录回到后台dashboard页面
  after_filter :store_location
  def store_location
    # store last url as long as it isn't a /users path
    if (request.fullpath != "/auth/login" &&
        request.fullpath != "/auth/password/new" &&
        request.fullpath != "/auth/logout" &&
        request.fullpath != "/auth/sign_up" &&
        request.fullpath != "/admin/auth/login" &&
        request.fullpath != "/admin/auth/password/new" &&
        request.fullpath != "/admin/auth/logout" &&
        request.fullpath != "/admin/auth/sign_up" &&
        request.fullpath != "/" &&
        request.fullpath != "/gym/code_image" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end
  #
  def after_sign_in_path_for(resource_or_scope)
    previous_url = session[:previous_url] 
    session[:previous_url] = nil
    previous_url || (resource_or_scope.instance_of?(Admin) ? admin_root_path : user_root_path)
  end
end
