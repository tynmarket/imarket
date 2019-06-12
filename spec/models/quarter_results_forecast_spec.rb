require "rails_helper"

describe QuarterResultsForecast do

  describe ".create" do
    context "latest_forecastなし" do
      let(:latest_forecast) {}
      let(:summaries) { [Summary.new(year: 2013, quarter: 4)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast).to be_nil }
    end

    context "summariesなし" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast).not_to be_nil }
    end
  end

  describe "#quarter_name_forecast" do
    context "4Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [Summary.new(year: 2013, quarter: 4)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.quarter_name_forecast).to eq("1Q - 4Q<br>予想") }
    end

    context "3Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 3)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.quarter_name_forecast).to eq("4Q予想") }
    end

    context "2Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 2)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.quarter_name_forecast).to eq("3Q - 4Q<br>予想") }
    end

    context "1Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 1)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.quarter_name_forecast).to eq("2Q - 4Q<br>予想") }
    end

    context "実績なし" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.quarter_name_forecast).to eq("1Q - 4Q<br>予想") }
    end
  end

  describe "#forecast_net_sales" do
    context "4Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4, forecast_net_sales: 100 }
      let(:summaries) { [Summary.new(year: 2013, quarter: 4, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to eq(100) }
    end

    context "3Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4, forecast_net_sales: 100 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 3, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to eq(10) }
    end

    context "2Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4, forecast_net_sales: 100 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 2, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to eq(10) }
    end

    context "1Q" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4, forecast_net_sales: 100 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 1, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to eq(10) }
    end

    context "予想の値なし" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 1, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to be_nil }
    end

    context "実績なし" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4, forecast_net_sales: 100 }
      let(:summaries) { [] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to eq(100) }
    end

    context "実績の値なし" do
      let(:latest_forecast) { LatestResultsForecast.new year: 2014, quarter: 4, forecast_net_sales: 100 }
      let(:summaries) { [Summary.new(year: 2014, quarter: 1)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.forecast_net_sales).to be_nil }
    end
  end

  describe "#change_in_forecast_net_sales" do
    context "4Q" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4,
        forecast_net_sales: 100, change_in_forecast_net_sales: 0.1) }
      let(:summaries) { [Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to eq(0.1) }
    end

    context "3Q" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 3, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 3, net_sales: 80)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to eq(0.1) }
    end

    context "2Q" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 2, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 3, net_sales: 85),
                         Summary.new(year: 2013, month: 3, quarter: 2, net_sales: 80)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to eq(0.1) }
    end

    context "1Q" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 1, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 3, net_sales: 85),
                         Summary.new(year: 2013, month: 3, quarter: 2, net_sales: 82),
                         Summary.new(year: 2013, month: 3, quarter: 1, net_sales: 80)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to eq(0.1) }
    end

    context "予想の値なし" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4) }
      let(:summaries) { [Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to be_nil }
    end

    context "前期の値なし" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 3, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 3)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to be_nil }
    end

    context "前期の値がマイナス" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 3, net_sales: 90),
                         Summary.new(year: 2013, quarter: 4, month: 3, net_sales: 80),
                         Summary.new(year: 2013, quarter: 3, month: 3, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to be_nil }
    end

    context "予想の値がマイナス" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 90) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 3, net_sales: 100),
                         Summary.new(year: 2013, quarter: 4, month: 3, net_sales: 100),
                         Summary.new(year: 2013, quarter: 3, month: 3, net_sales: 90)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to be_nil }
    end

    context "前年同期の短信がない" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 1, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90),
                         Summary.new(year: 2013, month: 12, quarter: 1, net_sales: 80)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to be_nil }
    end

    context "1Q発表前に通期業績予想を修正" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4,
        forecast_net_sales: 120) }
      let(:summaries) { [Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 100)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to eq(0.2) }
    end

    context "前期の短信がに欠落がある" do
      let(:latest_forecast) { LatestResultsForecast.new(year: 2014, month: 3, quarter: 4, forecast_net_sales: 101) }
      let(:summaries) { [Summary.new(year: 2014, month: 3, quarter: 2, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 4, net_sales: 90),
                         Summary.new(year: 2013, month: 3, quarter: 2, net_sales: 80)] }
      let(:quarter_forecast) { QuarterResultsForecast.create latest_forecast, summaries }

      it { expect(quarter_forecast.change_in_forecast_net_sales).to be_nil }
    end
  end

end
