require "rails_helper"

RSpec.describe LatestResultsForecast, type: :model do

  describe "#find_latest" do
    let(:code) { "1111" }
    let(:disclosure_summary) { create(:disclosure) }
    let(:latest_summary) { create :summary, disclosure: disclosure_summary }
    let(:latest_forecast) { LatestResultsForecast.find_latest(code, latest_summary) }

    context "来期予想あり" do
      it "来期の予想を取得する" do
        create :latest_forecast, year: 2015, month: 3,
          forecast_net_sales: 1, disclosure: create(:disclosure)

        expect(latest_forecast.year).to eq(2015)
      end
    end

    context "値が空の来期予想あり" do
      context "短信の業績予想" do
        it "来期の予想を取得しない" do
          create :latest_forecast, year: 2015, month: 3, disclosure: disclosure_summary

          expect(latest_forecast).to be_nil
        end
      end

      context "業績予想の修正" do
        it "来期の予想を取得する" do
          create :latest_forecast, year: 2015, month: 3, disclosure: create(:disclosure)

          expect(latest_forecast.year).to eq(2015)
        end
      end
    end

    context "来期予想なし" do
      it "今期の予想を取得しない" do
        expect(latest_forecast).to be_nil
      end
    end
  end

  describe "#quarter_name_forecast" do
    let(:forecast) { LatestResultsForecast.new quarter: quarter }

    context "1Q" do
      let(:quarter) { 4 }
      it { expect(forecast.quarter_name_forecast).to eq("4Q予想") }
    end

    context "quarter == nil" do
      let(:quarter) { nil }
      it { expect(forecast.quarter_name_forecast).to be_nil }
    end
  end

  describe "#values_present?" do
    let(:values_present) { forecast.values_present? }

    context "net_salesがある" do
      let(:forecast) { LatestResultsForecast.new forecast_net_sales: 1 }

      it { expect(values_present).to eq true }
    end

    context "forecast_net_salesがない" do
      let(:forecast) { LatestResultsForecast.new }

      it { expect(values_present).to eq false }
    end
  end

  describe "#calc_change_in_forecast_net_sales" do
    let(:forecast) { LatestResultsForecast.new(
      year: 2014,
      month: 3,
      quarter: 4,
      forecast_net_sales: 110,
    ) }
    let(:summaries) { [
      Summary.new(
        year: 2013,
        month: 3,
        quarter: 4,
        net_sales: 100,
      )
    ] }

    it { expect(forecast.calc_change_in_forecast_net_sales(summaries)).to eq 0.1 }
  end

end
