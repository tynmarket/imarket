module EpsEstimatesHelper

  def yafoo_us_url(code)
    link_to(code, "https://finance.yahoo.com/quote/#{code}", target: "_blank")
  end
end
