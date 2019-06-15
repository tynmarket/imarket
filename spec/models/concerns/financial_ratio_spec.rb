require "rails_helper"

describe FinancialRatio do
  include FinancialRatio

  describe "#net_sales_operating_income_ratio" do
    context "net_sales, operating_incomeあり" do
      let(:net_sales) { 1000 }
      let(:operating_income) { 111 }

      it { expect(net_sales_operating_income_ratio).to eq(0.111) }
    end

    context "net_sales == nil" do
      let(:net_sales) { nil }
      let(:operating_income) { 111 }

      it { expect(net_sales_operating_income_ratio).to be_nil }
    end

    context "net_sales == 0" do
      let(:net_sales) { 0 }
      let(:operating_income) { 111 }

      it { expect(net_sales_operating_income_ratio).to be_nil }
    end

    context "operating_income == nil" do
      let(:net_sales) { 1000 }
      let(:operating_income) { nil }

      it { expect(net_sales_operating_income_ratio).to be_nil }
    end
  end

  describe "#forecast_net_sales_operating_income_ratio" do
    context "forecast_net_sales, forecast_operating_incomeあり" do
      let(:forecast_net_sales) { 1000 }
      let(:forecast_operating_income) { 111 }

      it { expect(forecast_net_sales_operating_income_ratio).to eq(0.111) }
    end

    context "forecast_net_sales == nil" do
      let(:forecast_net_sales) { nil }
      let(:forecast_operating_income) { 111 }

      it { expect(forecast_net_sales_operating_income_ratio).to be_nil }
    end

    context "forecast_net_sales == 0" do
      let(:forecast_net_sales) { 0 }
      let(:forecast_operating_income) { 111 }

      it { expect(forecast_net_sales_operating_income_ratio).to be_nil }
    end

    context "forecast_operating_income == nil" do
      let(:forecast_net_sales) { 1000 }
      let(:forecast_operating_income) { nil }

      it { expect(forecast_net_sales_operating_income_ratio).to be_nil }
    end
  end

  describe "#net_sales_progress_ratio" do
    context "値あり" do
      let(:net_sales) { 111 }
      let(:results_forecast) { ResultsForecast.new forecast_net_sales: 1000 }

      it { expect(net_sales_progress_ratio(results_forecast)).to eq(11.1) }
    end

    context "net_sale == 0" do
      let(:net_sales) { 0 }
      let(:results_forecast) { ResultsForecast.new forecast_net_sales: 1000 }

      it { expect(net_sales_progress_ratio(results_forecast)).to eq(0.0) }
    end

    context "forecast_net_sales == 0" do
      let(:net_sales) { 111 }
      let(:results_forecast) { ResultsForecast.new forecast_net_sales: 0 }

      it { expect(net_sales_progress_ratio(results_forecast)).to eq(0.0) }
    end

    context "net_sales == nil" do
      let(:net_sales) { nil }
      let(:results_forecast) { ResultsForecast.new forecast_net_sales: 1000 }

      it { expect(net_sales_progress_ratio(results_forecast)).to be_nil }
    end

    context "results_forecast == nil" do
      let(:net_sales) { 111 }
      let(:results_forecast) { nil }

      it { expect(net_sales_progress_ratio(results_forecast)).to be_nil }
    end

    context "forecast_net_sales == nil" do
      let(:net_sales) { 111 }
      let(:results_forecast) { ResultsForecast.new }

      it { expect(net_sales_progress_ratio(results_forecast)).to be_nil }
    end
  end

end
