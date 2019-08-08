class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    @user = login_from(provider)

    if @user
      redirect_to root_path
    else
      begin
        @user = create_from(provider)

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to "#{root_path}?conversion"
      rescue
        redirect_to "#{root_path}?login-failure"
      end
    end
  end
end
