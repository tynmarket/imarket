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
    # ログアウト ⇒ ログインになる
    request.referer.include?("favorites") ? root_path : request.referer
  end
end
