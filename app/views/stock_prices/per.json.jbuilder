stock_prices = @stock_prices.map { |s| [s[0], s[1]] }.to_h

def render_per(ticks, dates, stock_prices, json)
  json.ticks do
    json.array! ticks
  end

  json.x_label do
    json.array! dates
  end

  json.data do
    json.array! dates.map.with_index { |d, i| [d, i] } do |date_idx|
      date, i = *date_idx
      stock_price = stock_prices[date]

      json.array! [i, stock_price]
    end
  end
end

json.current_year do
  render_per(@ticks_current_year, @dates_current_year, stock_prices, json)
end

json.entire_period do
  render_per(@ticks_entire_period, @dates_entire_period, stock_prices, json)
end
