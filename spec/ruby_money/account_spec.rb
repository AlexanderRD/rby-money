require 'spec_helper'

describe RubyMoney::Account do
  let(:account) { RubyMoney::Account.new(100, 'EUR') }

  it 'responds to #amount' do
    expect(account.amount).to eq 100
  end

  it 'responds to #currency' do
    expect(account.currency).to eq 'EUR'
  end

  it 'responds to #inspect with the expected content' do
    expect(account.inspect).to eq('100.00 EUR')
  end
end
