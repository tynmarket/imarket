require "rails_helper"

describe "GET /eps_estimates/:code/chart" do
  describe "code = 998407" do
    let(:code) { "998407" }
    let(:path) { chart_eps_estimate_path(code) }
    let(:date) { Date.new(2020, 5, 1) }
    let(:date_start) { Date.new(2020, 1, 6) }
    let(:x_label) { json["x_label"] }
    let(:data_n225) { json["data_n225"] }
    let(:data_n225_r) { json["data_n225_r"] }
    let(:data_close) { json["data_close"] }

    around { |e| travel_to(date) { e.run } }

    before do
      create :stock_price, :daily, :n225, close: 1.0, date: date_start
      create :stock_price, :daily, :n225, close: 2.0, date: date
      create :eps_estimate, :n225, current_year_eps: 3.0, date: date_start
      create :eps_estimate, :n225, current_year_eps: 4.0, date: date
      create :eps_estimate, :n225_r, current_year_eps: 5.0, date: date
    end

    it do
      get path

      expect(x_label).to eq ["2020-01-06", "2020-05-01"]
      expect(data_n225).to eq [3.0, 4.0]
      expect(data_n225_r).to eq [nil, 5.0]
      expect(data_close).to eq [1.0, 2.0]
    end
  end
end
