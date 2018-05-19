require 'rails_helper'

describe DisclosureCategory do
  include DisclosureCategory

  describe '#monthly?' do
    context 'category == MONTHLY' do
      let(:category) { 1 }

      it { expect(monthly?).to eq true }
    end

    context 'category == nil' do
      let(:category) { nil }

      it { expect(monthly?).to eq false }
    end
  end

end