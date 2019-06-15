require "rails_helper"

describe SystemStatus do

  describe ".stock_price_last_updated" do
    let(:format) { true }
    let(:last_updated) { SystemStatus.stock_price_last_updated format }

    context "データあり" do
      let(:status) { "2014年1月1日 0時0分" }

      before do
        create :system_status, :stock_price_last_updated, status: "2014-01-01T00:00:00+09:00"
      end

      it "株価反映日時を取得する" do
        expect(last_updated).to eq status
      end

      context "format = false" do
        let(:format) { false }

        it "DateTimeで取得する" do
          expect(last_updated).to eq DateTime.new(2014, 1, 1, 0, 0, 0, "+0900")
        end
      end
    end

    context "データなし" do
      it "returns nil" do
        expect(last_updated).to be_nil
      end
    end
  end

end
