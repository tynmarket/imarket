require 'rails_helper'

describe Stock do

  describe '.search' do
    context '証券コード' do
      let(:param) { "1111" }
      let(:count) { Stock.search(param).count }

      before { create :stock, id: 1111 }

      it { expect(count).to eq 1 }
    end

    context '証券コード（全角）' do
      let(:param) { "１１１１" }
      let(:count) { Stock.search(param).count }

      before { create :stock, id: 1111 }

      it { expect(count).to eq 1 }
    end

    context '漢字' do
      let(:param) { "扶桑化学" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: param }

      it { expect(count).to eq 1 }
    end

    context '全角カタカナ' do
      let(:param) { "フソウカガク" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "フソウカガク" }

      it { expect(count).to eq 1 }
    end

    context '半角カタカナ' do
      let(:param) { "ﾌｿｳｶｶﾞｸ" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "フソウカガク" }

      it { expect(count).to eq 0 }
    end

    context 'ひらがな' do
      let(:param) { "ふそうかがく" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "フソウカガク" }

      it { expect(count).to eq 1 }
    end

    context '全角英字大文字' do
      let(:param) { "ＯＳＧコーポ" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "osgコーポ" }

      it { expect(count).to eq 1 }
    end

    context '全角英字小文字' do
      let(:param) { "ｏｓｇコーポ" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "osgコーポ" }

      it { expect(count).to eq 1 }
    end

    context '半角英字小文字' do
      let(:param) { "osgコーポ" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "osgコーポ" }

      it { expect(count).to eq 1 }
    end

    context '全角数字' do
      let(:param) { "ソフト９９" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "ソフト99" }

      it { expect(count).to eq 1 }
    end

    context '半角数字' do
      let(:param) { "ソフト99" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "ソフト99" }

      it { expect(count).to eq 1 }
    end

    context '＆' do
      let(:param) { "＆" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "M&A" }

      it { expect(count).to eq 1 }
    end

    context 'ぁ' do
      let(:param) { "ぁ" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "ァ" }

      it { expect(count).to eq 1 }
    end

    context '後方一致' do
      let(:param) { "化学工業" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学工業" }

      it { expect(count).to eq 1 }
    end

    context '空白と株式会社の組み合わせ' do
      let(:param) { " 　扶桑化学 　" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学" }

      it { expect(count).to eq 1 }
    end

    context '株式会社' do
      let(:param) { "株式会社扶桑化学株式会社" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学" }

      it { expect(count).to eq 1 }
    end

    context '（株）' do
      let(:param) { "（株）扶桑化学（株）" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学" }

      it { expect(count).to eq 1 }
    end

    context '・' do
      let(:param) { "扶桑・化学" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学" }

      it { expect(count).to eq 1 }
    end

    context '複数語' do
      let(:param) { "oak キャピタル" }
      let(:count) { Stock.search(param).count }

      before do
        create :stock, id: 1, search_name: "oakキャピタル"
        create :stock, id: 2, search_name: "oakマネジメント"
      end

      it { expect(count).to eq 1 }
    end

    context 'nil' do
      let(:param) { nil }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学" }

      it { expect(count).to eq 0 }
    end

    context '空文字' do
      let(:param) { "" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "扶桑化学" }

      it { expect(count).to eq 0 }
    end

    context 'キーワード' do
      let(:param) { "sony" }
      let(:count) { Stock.search(param).count }

      before { create :stock, search_name: "ソニー,sony" }

      it { expect(count).to eq 1 }
    end

    context '複数該当' do
      let(:param) { "扶桑" }
      let(:count) { Stock.search(param).count }

      before do
        create :stock, search_name: "扶桑化学"
        create :stock, search_name: "扶桑薬品"
      end

      it { expect(count).to eq 2 }
    end
  end

  describe '.filter_index' do
    let(:filter_index) { Stock.filter_index code, user }

    context 'adminユーザ' do
      let(:user) { double admin?: true }

      context '日経平均' do
        let(:code) { "998407" }

        it { expect(filter_index).to eq code }
      end

      context '扶桑化学工業' do
        let(:code) { "4368" }

        it { expect(filter_index).to eq code }
      end
    end

    context 'adminユーザではない' do
      let(:user) { double admin?: false }

      context '日経平均' do
        let(:code) { "998407" }

        it { expect(filter_index).to eq code }
      end

      context '扶桑化学工業' do
        let(:code) { "4368" }

        it { expect(filter_index).to eq nil }
      end
    end
  end

  describe '.index?' do
    let(:index) { Stock.index? code }

    context '日経平均' do
      let(:code) { "998407" }

      it { expect(index).to eq true }
    end

    context '扶桑化学工業' do
      let(:code) { "4368" }

      it { expect(index).to eq false }
    end
  end

  describe '#per' do
    let(:stock) { Stock.last }

    context '株価がある' do
      it do
        create :stock_price, :latest, per: 10.5, stock: create(:stock)

        expect(stock.per).to eq 10.5
      end
    end

    context '株価がない' do
      it 'returns nil' do
        create :stock

        expect(stock.per).to be_nil
      end
    end
  end

end
