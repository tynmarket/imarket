class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    # sessionだと数回に1回リダイレクト後に空になっている。原因不明。
    cookies[:return_to_url] = params[:return_to_url] || request.referer
    cookies[:favorite_stock_id] = params[:favorite_stock_id]

    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)

    if @user
      add_favorite
      redirect_to redirect_url
    else
      begin
        @user = create_from(provider)

        reset_session # protect from session fixation attack
        auto_login(@user)
        add_favorite
        redirect_to "#{redirect_url}?conversion"
      rescue
        redirect_to "#{redirect_url}?login-failure"
      end
    end
  end

  private

  def add_favorite
    stock_id = cookies[:favorite_stock_id]

    return unless stock_id

    @user.add_favorite(stock_id)
  end

  def redirect_url
    return_to_url = cookies.delete(:return_to_url)

    if !return_to_url || return_to_url.include?("login")
      root_path
    else
      return_to_url
    end
  end
end
