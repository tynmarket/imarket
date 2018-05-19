class ApplicationController < ActionController::Base
  include Utils::Constants
  include Utils::UtilMethod

  protect_from_forgery with: :exception

  before_action :set_variant

  private

  def set_variant
    request.variant = :sp if browser.device.mobile?
  end
end
