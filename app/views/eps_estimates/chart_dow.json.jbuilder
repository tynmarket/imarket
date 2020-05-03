json.x_label do
  json.array! @dates
end

json.data_eps do
  json.current do
    json.array! @eps_estimates_current
  end

  json.next do
    json.array! @eps_estimates_next
  end
end

json.data_price do
  json.array! @stock_prices
end
