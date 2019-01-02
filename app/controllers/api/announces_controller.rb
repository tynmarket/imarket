class Api::AnnouncesController < Api::ApplicationController
  def financial_results
    codes = params[:code]&.split(',')

    if codes.present?
      render json: find_results(Summary, codes)
    else
      render json: []
    end
  end

  def forecast
    codes = params[:code]&.split(',')

    if codes.present?
      render json: find_results(ResultsForecast, codes)
    else
      render json: []
    end
  end

  private

  def find_results(klass, codes)
    from_str = params[:from]
    to_str = params[:to]

    from = Time.zone.parse(from_str) if from_str.present?
    to = Time.zone.parse(to_str) if to_str.present?

    klass
      .where(code: codes)
      .where(created_at: from..to)
      .pluck(:code)
      .uniq
  end
end
