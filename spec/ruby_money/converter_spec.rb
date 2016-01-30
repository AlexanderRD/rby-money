require 'spec_helper'

describe RubyMoney::Converter do
  let(:base_amount) { 10 }
  let(:usd_rate) { 1.2 }
  let(:converter) { RubyMoney::Converter.new('EUR', { 'USD'=>usd_rate }) }
  let(:euro_account) { RubyMoney::Account.new(base_amount, 'EUR') }
  let(:usd_account) { RubyMoney::Account.new(base_amount, 'USD') }

  it 'responds to #configure_rates' do
    expect(converter).to respond_to(:configure_rates)
  end

  context 'when determing the converted amount and the currency is a match' do
    it 'returns the original amount' do
      expect(converter.determine_amount(euro_account, 'EUR')).to eq base_amount
    end
  end

  context 'when determing the converted amount' do
    it 'returns a float' do
      expect(converter.determine_amount(euro_account, 'USD')).to be_kind_of(Float)
    end 

    it 'returns the expected result' do
      expect(converter.determine_amount(euro_account, 'USD')).to eq(base_amount*usd_rate)
    end 
  end
end
