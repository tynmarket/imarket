require "rails_helper"

describe FinancialInformation do

  describe "#accounting_period" do
    let(:summary) { Summary.new(
      year: 2013,
      month: 3) }

    it { expect(summary.accounting_period).to eq("2013/03") }
  end

  describe "#prev_accounting_period" do
    let(:summary) { Summary.new(
      year: 2013,
      month: 3) }

    it { expect(summary.prev_accounting_period).to eq("2012/03") }
  end

  describe "#accounting_period_once" do
    context "next_summary == nil" do
      let(:summary) { Summary.new year: 2014, month:3 }
      let(:next_summary) { nil }

      it { expect(summary.accounting_period_once(next_summary)).to eq("2014/03") }
    end

    context "同じ年度" do
      let(:summary) { Summary.new year: 2014, month:3 }
      let(:next_summary) { Summary.new year: 2014, month:3 }

      it { expect(summary.accounting_period_once(next_summary)).to be_nil }
    end

    context "次の年度" do
      let(:summary) { Summary.new year: 2014, month:3 }
      let(:next_summary) { Summary.new year: 2015, month:3 }

      it { expect(summary.accounting_period_once(next_summary)).to eq("2014/03") }
    end

    context "決算期の変更" do
      let(:summary) { Summary.new year: 2014, month:3, quarter:4 }
      let(:next_summary) { Summary.new year: 2014, month:12, quarter: 2 }

      it { expect(summary.accounting_period_once(next_summary)).to eq("2014/03") }
    end
  end

  describe "#quarter_name" do
    let(:summary) { Summary.new(quarter: quarter) }

    context "1Q" do
      let(:quarter) { 1 }
      it { expect(summary.quarter_name).to eq("1Q") }
    end
  end

end
