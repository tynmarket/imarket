json.x_label do
  json.array! @dates
end

json.data_eps do
  json.array! @eps_estimates_n225
end

json.data_price do
  json.array! @stock_prices
end
