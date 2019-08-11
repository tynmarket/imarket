class SessionsController < ApplicationController
  def destroy
    logout
    redirect_to request.referer
  end
end
