require "rails_helper"

describe SystemStatus do

  describe ".stock_price_last_updated" do
    let(:last_updated_text) { SystemStatus.stock_price_last_updated }

    context "更新あり" do
      let(:last_updated) { "2020-03-06T16:40:00+09:00" }

      before { create :system_status, :stock_price_last_updated, status: last_updated }

      context "営業日の17:00" do
        let(:now) { Time.local(2020, 3, 6, 17) }

        around { |e| travel_to(now){ e.run } }

        it { expect(last_updated_text).to eq "2020年3月6日 16時40分" }
      end

      context "休日" do
        let(:now) { Time.local(2020, 3, 7, 9) }

        around { |e| travel_to(now){ e.run } }

        it { expect(last_updated_text).to eq "2020年3月6日 16時40分" }
      end
    end

    context "更新なし" do
      let(:last_updated) { "2020-03-05T16:40:00+09:00" }

      before { create :system_status, :stock_price_last_updated, status: last_updated }

      context "営業日の16:00" do
        let(:now) { Time.local(2020, 3, 6, 16) }

        around { |e| travel_to(now){ e.run } }

        it { expect(last_updated_text).to eq "2020年3月5日 16時40分" }
      end

      context "営業日の17:00" do
        let(:now) { Time.local(2020, 3, 6, 17) }

        around { |e| travel_to(now){ e.run } }

        it { expect(last_updated_text).to eq "2020年3月5日 16時40分（更新が遅れています）" }
      end

      context "休日" do
        let(:now) { Time.local(2020, 3, 7, 9) }

        around { |e| travel_to(now){ e.run } }

        it { expect(last_updated_text).to eq "2020年3月5日 16時40分（更新が遅れています）" }
      end
    end

    context "データなし" do
      it "returns nil" do
        expect(last_updated_text).to be_nil
      end
    end
  end
end
