class SessionsController < ApplicationController
  def new
    @return_to_url = params[:return_to_url]
    @favorite_stock_id = params[:favorite_stock_id]
  end

  def destroy
    logout
    redirect_to redirect_path
  end

  private

  def redirect_path
    if request.referer.include?("favorites") ||
       request.referer.include?("login")
      root_path
    else
      request.referer
    end
  end
end
