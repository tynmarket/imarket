require "rails_helper"

describe "GET /api/announces" do
  let(:code) { "1111,2222,3333,4444" }
  let(:from) { "2019-01-10 14:0:0" }
  let(:to) { "2019-01-10 14:59:59" }

  describe "GET /api/announces/financial_results" do

    context "from=2019-01-10 14:0:0, to=2019-01-10 14:59:59" do
      before do
        create :summary, code: "1111", created_at: Time.zone.local(2019, 1, 10, 14),
          disclosure: create(:disclosure, code: "1111")
        create :summary, code: "2222", created_at: Time.zone.local(2019, 1, 10, 14, 59, 59),
          disclosure: create(:disclosure, code: "2222")
        create :summary, code: "3333", created_at: Time.zone.local(2019, 1, 10, 13, 59, 59),
          disclosure: create(:disclosure, code: "3333")
        create :summary, code: "4444", created_at: Time.zone.local(2019, 1, 10, 15, 0, 0),
          disclosure: create(:disclosure, code: "4444")
      end

      it "1111, 2222" do
        get financial_results_api_announce_path,
          params: {code: code, from: from, to: to},
          headers: auth_header

        expect(json).to eq ["1111", "2222"]
      end
    end
  end

  describe "GET /api/announces/forecast" do

    context "from=2019-01-10 14:0:0, to=2019-01-10 14:59:59" do
      before do
        create :results_forecast, code: "1111", created_at: Time.zone.local(2019, 1, 10, 14),
          disclosure: create(:disclosure, code: "1111")
        create :results_forecast, code: "2222", created_at: Time.zone.local(2019, 1, 10, 14, 59, 59),
          disclosure: create(:disclosure, code: "2222")
        create :results_forecast, code: "3333", created_at: Time.zone.local(2019, 1, 10, 13, 59, 59),
          disclosure: create(:disclosure, code: "3333")
        create :results_forecast, code: "4444", created_at: Time.zone.local(2019, 1, 10, 15, 0, 0),
          disclosure: create(:disclosure, code: "4444")
      end

      it "1111, 2222" do
        get forecast_api_announce_path,
          params: {code: code, from: from, to: to},
          headers: auth_header

        expect(json).to eq ["1111", "2222"]
      end
    end
  end

end
