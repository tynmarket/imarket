require "rails_helper"

describe "GET /eps_estimates/:code/chart" do
  let(:path) { chart_eps_estimate_path(code) }
  let(:date) { Date.new(2020, 5, 1) }
  let(:date_start) { Date.new(2020, 1, 6) }
  let(:x_label) { json["x_label"] }
  let(:data_eps) { json["data_eps"] }
  let(:data_price) { json["data_price"] }

  around { |e| travel_to(date) { e.run } }

  describe "code = 998407" do
    let(:code) { "998407" }

    before do
      create :stock_price, :daily, :n225, close: 1.0, date: date_start
      create :stock_price, :daily, :n225, close: 2.0, date: date
      create :eps_estimate, :n225, current_year_eps: 3.0, date: date_start
      create :eps_estimate, :n225, current_year_eps: 4.0, date: date
    end

    it do
      get path

      expect(x_label).to eq ["2020-01-06", "2020-05-01"]
      expect(data_eps).to eq [3.0, 4.0]
      expect(data_price).to eq [1.0, 2.0]
    end
  end

  describe "code = 998407-r" do
    let(:code) { "998407-r" }

    before do
      create :stock_price, :daily, :n225, close: 1.0, date: date_start
      create :stock_price, :daily, :n225, close: 2.0, date: date
      create :eps_estimate, :n225_r, current_year_eps: 3.0, date: date_start
      create :eps_estimate, :n225_r, current_year_eps: 4.0, date: date
    end

    it do
      get path

      expect(x_label).to eq ["2020-01-06", "2020-05-01"]
      expect(data_eps).to eq [3.0, 4.0]
      expect(data_price).to eq [1.0, 2.0]
    end
  end
end
