class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    # sessionだと数回に1回リダイレクト後に空になっている。原因不明。
    cookies[:return_to_url] = request.referer

    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)

    if @user
      redirect_to redirect_url
    else
      begin
        @user = create_from(provider)

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to "#{redirect_url}?conversion"
      rescue
        redirect_to "#{redirect_url}?login-failure"
      end
    end
  end

  def redirect_url
    cookies.delete(:return_to_url) || root_path
  end
end
