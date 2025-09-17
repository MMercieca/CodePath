# frozen_string_literal: true

require 'github/markup'
require 'commonmarker'

class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  rescue_from AuthorizationException, with: :unauthorized

  def render_markdown(content)
    Commonmarker.to_html(content, options: { parse: { smart: true } }).html_safe
  end
  helper_method :render_markdown

  def unauthorized
    flash[:error] = "That is not permitted"
    redirect_to "/"
  end

  def after_sign_in_path_for(user)
    "/dashboard"
  end

  def authenticate_admin_user!
    authenticate_user!

    raise AuthorizationException unless current_user.admin?
  end

end
