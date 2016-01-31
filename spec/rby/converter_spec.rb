require 'spec_helper'

describe Rby::Converter do
  let(:base_amount) { 10 }
  let(:usd_rate) { 1.2 }
  let(:converter) { Rby::Converter.new('EUR', { 'USD'=>usd_rate }) }
  let(:euro_account) { Rby::Account.new(base_amount, 'EUR') }
  let(:usd_account) { Rby::Account.new(base_amount, 'USD') }

  it 'responds to #configure_rates' do
    expect(converter).to respond_to(:configure_rates)
  end

  context 'when #determine_amount called and the currencies are a match' do
    it 'returns the original amount' do
      expect(converter.determine_amount(euro_account, 'EUR')).to eq base_amount
    end
  end

  context 'calling #determine_amount and the currencies do not match' do
    it 'returns a Numeric' do
      expect(converter.determine_amount(euro_account, 'USD')).to be_kind_of(Numeric)
    end 

    it 'returns the expected amount' do
      expect(converter.determine_amount(euro_account, 'USD')).to eq(base_amount*usd_rate)
    end 
  end
end
