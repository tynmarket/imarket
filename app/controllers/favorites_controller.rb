class FavoritesController < ApplicationController
  before_action :require_login

  def index
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
end
