class EpsEstimatesController < ApplicationController
  def index
    @eps_estimates = EpsEstimate.dow_constituents.order("id desc")
    @eps_estimate_classes = estimate_class(@eps_estimates)
    @dow_estimates = EpsEstimate.dow.order("id desc")
  end

  private

  def estimate_class(eps_estimates)
    eps_estimate_classes = []
    prev_estimates = {}

    eps_estimates.reverse.each do |eps_estimate|
      prev_estimate = prev_estimates[eps_estimate.code]
      eps_estimate_class = {}

      unless prev_estimate
        eps_estimate_classes << eps_estimate_class
        prev_estimates[eps_estimate.code] = eps_estimate
        next
      end

      [:current_quarter_eps, :next_quarter_eps, :current_year_eps, :next_year_eps].each do |attr|
        diff = eps_estimate.send(attr) - prev_estimate.send(attr)

        next if diff == 0

        class_name = diff > 0 ? "text-bold" : "text-bold red"
        eps_estimate_class[attr] = class_name
        eps_estimate_class[eps_estimate.code] = prev_estimate
      end

      eps_estimate_classes << eps_estimate_class

      prev_estimates[eps_estimate.code] = eps_estimate
    end

    eps_estimate_classes.reverse
  end
end
