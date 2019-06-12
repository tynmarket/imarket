require "rails_helper"

describe CashFlow do

  describe "#net_increase_in_cash" do
    context "通期のみ" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 4,
        cash: 100
      ) }
      let(:prev_cash_flow) { CashFlow.new(
        year: 2018,
        month: 3,
        quarter: 4,
        cash: 90
      ) }

      it { expect(cash_flow.net_increase_in_cash prev_cash_flow).to eq 10 }
    end

    context "通期以外もある" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 4,
        cash: 100,
        net_increase_in_cash: 20
      ) }
      let(:prev_cash_flow) { CashFlow.new(
        year: 2018,
        month: 3,
        quarter: 3,
        cash: 90
      ) }

      it { expect(cash_flow.net_increase_in_cash prev_cash_flow).to eq 20 }
    end

    context "前期なし" do
      let(:cash_flow) { CashFlow.new(
        year: 2019,
        month: 3,
        quarter: 4,
        cash: 100,
        net_increase_in_cash: 20
      ) }
      let(:prev_cash_flow) { nil }

      it { expect(cash_flow.net_increase_in_cash prev_cash_flow).to eq 20 }
    end
  end

end
