require "rails_helper"

describe "GET /stock_prices/:id/per.json" do
  let(:id) { "1111" }
  let(:ticks) { json_data["ticks"] }
  let(:x_label) { json_data["x_label"] }
  let(:data) { json_data["data"] }

  before do
    Timecop.travel Date.new(2014, 8, 1)
    create :stock_price, :daily, per: 9.0, date: Date.new(2011, 1, 4)
    create :stock_price, :daily, per: 10.0, date: Date.new(2014, 1, 6)
    create :stock_price, :daily, per: 11.0, date: Date.new(2014, 1, 8)

    get "/stock_prices/#{id}/per.json"
  end

  context "current_year" do
    let(:json_data) { json["current_year"] }

    it "x_label" do
      expect(x_label.first).to eq "2014-01-06"
      expect(x_label.last).to eq "2014-12-30"
    end

    context "data" do
      it { expect(data.size).to eq x_label.size }

      context "株価がある" do
        it "PERを出力する" do
          expect(data[0]).to eq 10.0
          expect(data[2]).to eq 11.0
        end
      end

      context "株価がない" do
        it "PERを出力しない" do
          expect(data[1]).to eq nil
        end
      end
    end
  end

  context "entire_period" do
    let(:json_data) { json["entire_period"] }

    it "x_label" do
      expect(x_label.first).to eq "2011-01-04"
      expect(x_label.last).to eq "2014-12-30"
    end

    context "data" do
      it { expect(data.size).to eq x_label.size }

      it { expect(data[0]).to eq 9.0 }
    end
  end
end

describe "GET /stock_prices/:id/pbr.json" do
  let(:id) { "1111" }
  let(:ticks) { json_data["ticks"] }
  let(:x_label) { json_data["x_label"] }
  let(:data) { json_data["data"] }

  before do
    Timecop.travel Date.new(2014, 8, 1)
    create :stock_price, :daily, pbr: 9.0, date: Date.new(2011, 1, 4)
    create :stock_price, :daily, pbr: 10.0, date: Date.new(2014, 1, 6)
    create :stock_price, :daily, pbr: 11.0, date: Date.new(2014, 1, 8)

    get "/stock_prices/#{id}/pbr.json"
  end

  context "current_year" do
    let(:json_data) { json["current_year"] }

    it "x_label" do
      expect(x_label.first).to eq "2014-01-06"
      expect(x_label.last).to eq "2014-12-30"
    end

    context "data" do
      it { expect(data.size).to eq x_label.size }

      context "株価がある" do
        it "PERを出力する" do
          expect(data[0]).to eq 10.0
          expect(data[2]).to eq 11.0
        end
      end

      context "株価がない" do
        it "PERを出力しない" do
          expect(data[1]).to eq nil
        end
      end
    end
  end

  context "entire_period" do
    let(:json_data) { json["entire_period"] }

    it "x_label" do
      expect(x_label.first).to eq "2011-01-04"
      expect(x_label.last).to eq "2014-12-30"
    end

    context "data" do
      it { expect(data.size).to eq x_label.size }

      it { expect(data[0]).to eq 9.0 }
    end
  end
end
