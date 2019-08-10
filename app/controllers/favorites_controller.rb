class FavoritesController < ApplicationController
  before_action :require_login

  def index
  end

  def create
    head :ok
  end

  def destroy
    head :ok
  end
end
