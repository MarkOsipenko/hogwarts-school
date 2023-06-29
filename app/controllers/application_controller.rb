class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= Student.find_by_id(1)
  end
end
