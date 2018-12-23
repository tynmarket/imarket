class StockPriceSerializer < ActiveModel::Serializer
  attributes :close, :change, :change_rate, :per, :pbr
end
