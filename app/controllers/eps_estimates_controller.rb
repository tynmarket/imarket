class EpsEstimatesController < ApplicationController

  def index
    @tab = params[:tab] || "n225"
    eps_estimates_n225
    eps_estimates_dow
  end

  private

  def eps_estimates_n225
    attrs = [:current_year_eps]

    @n225_r_estimates = EpsEstimate.n225_r.order("id desc")
    @n225_r_estimates_classes = estimate_classes(@n225_r_estimates, attrs)
    @n225_estimates = EpsEstimate.n225.order("id desc")
    @n225_estimates_classes = estimate_classes(@n225_estimates, attrs)
  end

  def eps_estimates_dow
    attrs = [:current_quarter_eps, :next_quarter_eps, :current_year_eps, :next_year_eps]

    @dow_estimates = EpsEstimate.dow.order("id desc")
    @dow_estimate_classes = estimate_classes(@dow_estimates, attrs)
    @dow_constituent_estimates = EpsEstimate.dow_constituents.order("id desc")
    @dow_constituent_estimate_classes = estimate_classes(@dow_constituent_estimates, attrs)
  end

  def estimate_classes(eps_estimates, attrs)
    eps_estimate_classes = []
    prev_estimates = {}

    eps_estimates.reverse.each do |eps_estimate|
      prev_estimate = prev_estimates[eps_estimate.code]

      unless prev_estimate
        eps_estimate_classes << {}
        prev_estimates[eps_estimate.code] = eps_estimate
        next
      end

      eps_estimate_classes << estimate_class(eps_estimate, prev_estimate, attrs)

      prev_estimates[eps_estimate.code] = eps_estimate
    end

    eps_estimate_classes.reverse
  end

  def estimate_class(eps_estimate, prev_estimate, attrs)
    eps_estimate_class = {}

    attrs.each do |attr|
      diff = eps_estimate.send(attr) - prev_estimate.send(attr)

      next if diff == 0

      class_name = diff > 0 ? "text-bold green" : "text-bold red"
      eps_estimate_class[attr] = class_name
      eps_estimate_class[eps_estimate.code] = prev_estimate
    end

    eps_estimate_class
  end
end
