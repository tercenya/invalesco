class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :app_name

  def app_name
    @app_name = 'Invalesco'
  end

  def sample_match
    render json: Match.first.to_json
  end
end