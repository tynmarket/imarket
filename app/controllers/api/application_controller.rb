class Api::ApplicationController < ApplicationController
  before_action :authenticate

  private

  def authenticate
    token_str = request.headers["Authorization"]
    api_key = token_str&.split("token ")&.fetch(1)

    head :unauthorized if api_key.blank?
    head :unauthorized if api_key != Settings.imarket.api_key
  end
end
