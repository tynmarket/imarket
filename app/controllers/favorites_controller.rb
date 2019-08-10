class FavoritesController < ApplicationController
  before_action :require_login

  def index
  end

  def create
    stock = find_stock
    Favorite.create!(stock_id: stock.id, user_id: current_user.id)

    head :ok
  end

  def destroy
    stock = find_stock
    current_user.favorite(stock.id).destroy!

    head :ok
  end

  private

  def find_stock
    Stock.find(params[:stock_id])
  end
end
