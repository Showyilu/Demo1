class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    @current_user = AuthenticationService.new(request.headers).run.data
    @current_user
  end
end
