require "rails_helper"

describe "GET /api/stock_prices/:code" do
  let(:code) { "1111" }
  let(:date) { "2018-10-10" }

  context "Authorizationヘッダなし" do
    it "401" do
      get api_stock_price_path(code), params: { date: date }

      expect(response.status).to eq 401
    end
  end

  context "tokenが不正" do
    it "401" do
      get api_stock_price_path(code), params: { date: date }, headers: { Authorization: "token bad_api_key" }

      expect(response.status).to eq 401
    end
  end

  context "date=2018-10-10" do
    let(:close) { 2100 }
    let(:change) { 50 }
    let(:change_rate) { 0.0233 }
    let(:per) { 20.5 }
    let(:pbr) { 1.25 }

    before do
      create :stock_price, :daily, code: code, stock: (create :stock, code: code),
        date: Date.new(2018, 10, 10), close: close, change: change,
        change_rate: change_rate, per: per, pbr: pbr
    end

    it "" do
      get api_stock_price_path(code), params: { date: date }, headers: auth_header

      expect(json[:close]).to eq close
      expect(json[:change]).to eq change
      expect(json[:change_rate]).to eq change_rate
      expect(json[:per]).to eq per
      expect(json[:pbr]).to eq pbr
    end
  end
end
