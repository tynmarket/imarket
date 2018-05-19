require 'rails_helper'

describe Disclosure do

  describe '#results_forecast_q4' do
    it 'true' do
      disclosure = Disclosure.new
      disclosure.results_forecasts = [ResultsForecast.new(quarter: 4)]

      expect(disclosure.results_forecast_q4.quarter).to eq 4
    end
  end

  describe '.monthly' do
    let(:monthly) { Disclosure.monthly }

    context 'category == MONTHLY' do
      it do
        create :disclosure, category: Disclosure::MONTHLY

        expect(monthly.present?).to eq true
      end
    end

    context 'category == nil' do
      it do
        create :disclosure

        expect(monthly.present?).to eq false
      end
    end
  end

end
