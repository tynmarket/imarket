class FavoritesController < ApplicationController
  before_action :require_login, except: [:show]

  def index
    today = Date.today

    @stocks = Stock.joins(:favorites).where(favorites: { user_id: current_user.id }).order(:code)
    @disclosures = Disclosure
      .where(code: @stocks.map(&:code))
      .where(release_date: (today.prev_month)...today)
      .order(id: :desc)
  end

  def show
    return unless logged_in?

    favorite = current_user.favorite_exist?(params[:stock_id])

    render(json: { status: :ok }) if favorite
  end

  def create
    current_user.add_favorite(params[:stock_id])

    head :ok
  end

  def destroy
    current_user.favorite(params[:stock_id])&.destroy

    head :ok
  end

  private

  def not_authenticated
    # ログイン後、お気に入り一覧に飛ばす
    redirect_to login_path(return_to_url: request.url)
  end
end
