class FavoritesController < ApplicationController
  before_action :require_login

  def index
    @stocks = Stock.joins(:favorites).where(favorites: { user_id: current_user.id }).order(:code)
  end

  def show
    favorite = current_user.favorite_exist?(params[:stock_id])

    render(json: { status: :ok }) if favorite
  end

  def create
    Favorite.create!(stock_id: params[:stock_id], user_id: current_user.id)

    head :ok
  end

  def destroy
    current_user.favorite(params[:stock_id]).destroy!

    head :ok
  end

  private

  def not_authenticated
    redirect_to auth_at_provider_path(provider: :google, return_to_url: request.url)
  end
end
