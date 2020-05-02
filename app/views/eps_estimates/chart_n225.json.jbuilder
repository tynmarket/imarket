json.x_label do
  json.array! @dates
end

json.data_n225 do
  json.array! @eps_estimates_n225
end

json.data_n225_r do
  json.array! @eps_estimates_n225_r
end

json.data_close do
  json.array! @stock_prices
end
