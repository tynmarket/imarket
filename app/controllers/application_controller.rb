class ApplicationController < ActionController::Base
  include Utils::Constants
  include Utils::UtilMethod

  protect_from_forgery with: :exception

  before_action :set_variant

  rescue_from ActiveRecord::RecordNotFound, with: :error_404 unless Rails.env.development?

  private

  def error_404
    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end

  def set_variant
    request.variant = :sp if browser.device.mobile?
  end
end
