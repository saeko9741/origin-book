class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

	protected
	def configure_permitted_parameters
	  devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
	end
  # モーダルウィンドウでログイン後のリダイレクト先
  def after_sign_in_path_for(resource_or_scope)
    if params[:modal] == "0"
        new_wordbook_path(search_cache_id: params[:search_cache_id])
    else
      root_path
    end
  end
  # モーダルウィンドウでサインアップ後のリダイレクト先
  def after_sign_up_path_for(resource_or_scope)
    if params[:modal] == "0"
      new_wordbook_path(search_cache_id: params[:search_cache_id])
    else
      root_path
    end
  end
end
