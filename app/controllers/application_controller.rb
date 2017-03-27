class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def not_found_json(resource)
    render json: { alert: t('not_found', resource: resource) }, status: :not_found
  end
end
