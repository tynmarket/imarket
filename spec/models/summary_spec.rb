require "rails_helper"

describe Summary do

  describe "results_forecast_dummy" do
    context "1Q" do
      let(:summary) { Summary.new year: 2014, quarter: 1 }

      it do
        dummy = summary.results_forecast_dummy
        expect(dummy.year).to eq(2014)
      end
    end

    context "4Q" do
      let(:summary) { Summary.new year: 2014, quarter: 4 }

      it do
        dummy = summary.results_forecast_dummy
        expect(dummy.year).to eq(2015)
      end
    end

    context "year == nil" do
      let(:summary) { Summary.new }

      it do
        dummy = summary.results_forecast_dummy
        expect(dummy.year).to be_nil
      end
    end
  end

end
