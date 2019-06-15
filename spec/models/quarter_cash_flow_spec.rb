require "rails_helper"

describe QuarterCashFlow do

  describe "#operating_activities" do
    context "1Q・前期なし" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 1,
        operating_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { nil }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.operating_activities).to eq(100) }
    end

    context "2Q・前期なし" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        operating_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { nil }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.operating_activities).to eq(100) }
    end

    context "2Q・前期1Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        operating_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 1,
        operating_activities: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.operating_activities).to eq(10) }
    end

    context "2Q・前期4Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        operating_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2018,
        month: 3,
        quarter: 4,
        operating_activities: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.operating_activities).to eq(100) }
    end

    context "4Q・前期3Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 4,
        operating_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 3,
        operating_activities: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.operating_activities).to eq(10) }
    end

    context "4Q・前期2Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 4,
        operating_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        operating_activities: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.operating_activities).to eq(10) }
    end
  end

  describe "#investment_activities" do
    context "2Q・前期1Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        investment_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 1,
        investment_activities: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.investment_activities).to eq(10) }
    end
  end

  describe "#financing_activities" do
    context "2Q・前期1Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        financing_activities: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 1,
        financing_activities: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.financing_activities).to eq(10) }
    end
  end

  describe "#net_increase_in_cash" do
    context "2Q・前期1Q" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 2,
        net_increase_in_cash: 100
      ) }
      let(:prev_quarter_cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 1,
        net_increase_in_cash: 90
      ) }
      let(:quarter_cash_flow) { QuarterCashFlow.new cash_flow, prev_quarter_cash_flow }

      it { expect(quarter_cash_flow.net_increase_in_cash).to eq(10) }
    end
  end

end
