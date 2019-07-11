stock_prices = @stock_prices.map { |s| [s[0], s[1]] }.to_h

def render_per(dates, stock_prices, json)
  json.x_label do
    json.array! dates
  end

  data = dates.map do |date|
    stock_prices[date]
  end

  json.data do
    json.array! data
  end
end

json.current_year do
  render_per(@dates_current_year, stock_prices, json)
end

json.entire_period do
  render_per(@dates_entire_period, stock_prices, json)
end
