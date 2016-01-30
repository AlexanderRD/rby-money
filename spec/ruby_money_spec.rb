require 'spec_helper'

describe Ruby::Money do
  let(:euro_money) { Ruby::Money.new(10,'EUR') }

  it 'has a version number' do
    expect(RubyMoney::VERSION).not_to be nil
  end

  it 'responds to #amount with a fixnum' do
    expect(euro_money.amount).to be_kind_of(Fixnum)
  end

  it 'responds to #currency with a String' do
    expect(euro_money.currency).to be_kind_of(String)
  end

  it 'responds to #inspect with a String' do
    expect(euro_money.inspect).to be_kind_of(String)
  end

  it 'responds to #inspect with the expected content' do
    expect(euro_money.inspect).to eq('10.00 EUR')
  end

  context 'when the conversion rates have been set' do
    before :each do
      Ruby::Money.conversion_rates('EUR', {'USD' => 1.2} )
    end

    it 'responds to #convert_to with a RubyMoney object' do
      expect(euro_money.convert_to('USD')).to be_kind_of(Ruby::Money)
    end

    it 'does not update the original account when performing #convert_to' do
      usd_money = euro_money.convert_to('USD')
      expect(euro_money.currency).to eq('EUR')
    end
  end
end
