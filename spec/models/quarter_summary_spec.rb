require "rails_helper"

describe QuarterSummary do

  describe ".arrays" do
    context "連続したSummary2つ" do
      let(:summary) { Summary.new year: 2014, quarter: 1 }
      let(:summary_2) { Summary.new year: 2013, quarter: 4 }
      let(:summaries) { [summary, summary_2] }
      let(:quarter_summaries) { QuarterSummary.arrays(summaries) }

      it "1つ目" do
        quarter_summary = quarter_summaries.first
        prev_quarter_summary = quarter_summary.instance_variable_get(:@prev_quarter_summary)

        expect(quarter_summary.year).to eq(2014)
        expect(quarter_summary.quarter).to eq(1)
        expect(prev_quarter_summary.year).to eq(2013)
        expect(prev_quarter_summary.quarter).to eq(4)
      end

      it "2つ目" do
        quarter_summary = quarter_summaries.second
        prev_quarter_summary = quarter_summary.instance_variable_get(:@prev_quarter_summary)

        expect(quarter_summary.year).to eq(2013)
        expect(quarter_summary.quarter).to eq(4)
        expect(prev_quarter_summary).to be_nil
      end
    end

    context "空" do
      let(:summaries) { [] }
      let(:quarter_summaries) { QuarterSummary.arrays(summaries) }

      it { expect(quarter_summaries).to eq([]) }
    end
  end

  describe "#net_sales" do
    context "2Q" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 2,
        net_sales: 100) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(10) }
    end

    context "1Q・前期4Q" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1,
        net_sales: 100) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2013,
        month: 3,
        quarter: 4,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(100) }
    end

    context "1Q・前期0Q" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1,
        net_sales: 100) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        quarter: 0,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(10) }
    end

    context "1Q・前期なし" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1,
        net_sales: 100) }
      let(:prev_quarter_summary) {}
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(100) }
    end

    context "1Q値なし・前期0Q" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 0,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to be_nil }
    end

    context "1Q・前期0Q値なし" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1,
        net_sales: 100) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 0) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to be_nil }
    end

    context "0Q・前期4Q" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 0,
        net_sales: 100) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2013,
        month: 3,
        quarter: 4,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(100) }
    end

    context "当期値なし" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 2) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to be_nil }
    end

    context "2Q・前期なし" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 2,
        net_sales: 100) }
      let(:quarter_summary) { QuarterSummary.new summary, nil }

      it { expect(quarter_summary.net_sales).to be_nil }
    end

    context "2Q・前期値なし" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 2,
        net_sales: 100) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 1) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to be_nil }
    end

    context "決算期の変更" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 12,
        quarter: 2,
        net_sales: 10) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 4,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(10) }
    end

    context "決算期の変更（修正バッチ適用前）" do
      let(:summary) { Summary.new(
        year: 2014,
        month: 12,
        quarter: 1,
        net_sales: 10) }
      let(:prev_quarter_summary) { Summary.new(
        year: 2014,
        month: 3,
        quarter: 4,
        net_sales: 90) }
      let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }

      it { expect(quarter_summary.net_sales).to eq(10) }
    end
  end

  describe "#change_in_net_sales" do
    let(:summary) { Summary.new(
      year: 2014,
      quarter: 2,
      month: 3,
      net_sales: 210) }
    let(:prev_quarter_summary) { Summary.new(
      year: 2014,
      quarter: 1,
      month: 3,
      net_sales: 100) }
    let(:quarter_summary) { QuarterSummary.new summary, prev_quarter_summary }
    let(:prev_year_summary) { Summary.new(
      year: 2013,
      quarter: 2,
      month: 3,
      net_sales: 150) }
    let(:prev_year_prev_quarter_summary) { Summary.new(
      year: 2013,
      quarter: 1,
      month: 3,
      net_sales: 50) }
    let(:prev_year_quarter_summary) { QuarterSummary.new prev_year_summary, prev_year_prev_quarter_summary }
    let(:change_in_net_sales) { quarter_summary.change_in_net_sales(prev_year_quarter_summary) }

    it { expect(change_in_net_sales).to eq(0.10) }

    context "prev_year_quarter_summaryなし" do
      it do
        change_in_net_sales = quarter_summary.change_in_net_sales(nil)

        expect(change_in_net_sales).to be_nil
      end
    end

    context "quarter_summaryの値なし" do
      it do
        allow(quarter_summary).to receive(:net_sales) { nil }

        expect(change_in_net_sales).to be_nil
      end
    end

    context "prev_year_quarter_summaryの値なし" do
      it do
        allow(prev_year_quarter_summary).to receive(:net_sales) { nil }

        expect(change_in_net_sales).to be_nil
      end
    end

    context "prev_year_quarter_summaryが前年ではない" do
      it do
        prev_year_quarter_summary.instance_variable_set :@year, 2012

        expect(change_in_net_sales).to be_nil
      end
    end

    context "prev_year_quarter_summaryが同決算月ではない" do
      it do
        prev_year_quarter_summary.instance_variable_set :@month, 1

        expect(change_in_net_sales).to be_nil
      end
    end

    context "prev_year_quarter_summaryが同四半期ではない" do
      it do
        prev_year_quarter_summary.instance_variable_set :@quarter, 1

        expect(change_in_net_sales).to be_nil
      end
    end

    context "quarter_summaryが負の値" do
      it do
        allow(quarter_summary).to receive(:net_sales) { -10 }

        expect(change_in_net_sales).to be_nil
      end
    end

    context "prev_year_quarter_summaryが負の値" do
      it do
        allow(prev_year_quarter_summary).to receive(:net_sales) { -10 }

        expect(change_in_net_sales).to be_nil
      end
    end
  end

end
