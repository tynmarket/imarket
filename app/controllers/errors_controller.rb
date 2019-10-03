class ErrorsController < ActionController::Base

  def error
    head :bad_request
  end
end
