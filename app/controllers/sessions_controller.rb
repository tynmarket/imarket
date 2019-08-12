class SessionsController < ApplicationController
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
