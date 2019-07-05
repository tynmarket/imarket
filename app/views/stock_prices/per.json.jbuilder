stock_prices = @stock_prices.map { |s| [s[0], s[1]] }.to_h

def render_per(dates, stock_prices, json)
  json.x_label do
    json.array! dates
  end

  dates_with_index = dates.map.with_index { |d, i| [d, i] }

  json.data do
    json.array! dates_with_index do |date_idx|
      date, i = *date_idx
      stock_price = stock_prices[date]

      json.array! [i, stock_price]
    end
  end
end

json.current_year do
  render_per(@dates_current_year, stock_prices, json)
end

json.entire_period do
  render_per(@dates_entire_period, stock_prices, json)
end
