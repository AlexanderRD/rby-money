require 'spec_helper'

describe Rby::Money do
  let(:euro_money) { Rby::Money.new(10,'EUR') }

  subject { euro_money }
  it { should respond_to(:inspect) }
  it { should respond_to(:amount) }
  it { should respond_to(:currency) }
  it { should respond_to(:+, :-, :/, :*, :==, :<, :>) }

  it 'responds to #inspect with a String' do
    expect(euro_money.inspect).to be_kind_of String
  end

  it 'responds to #inspect with a String' do
    expect(euro_money.inspect).to be_kind_of String
  end

  it 'responds to #inspect with the expected content' do
    expect(euro_money.inspect).to eq('10.00 EUR')
  end

  context 'when the conversion rates have been set' do
    before :each do
      Rby::Money.conversion_rates('EUR', {'USD' => 1.11} )
    end

    context '#convert_to' do
      it 'responds with a Rby::Money object' do
        expect(euro_money.convert_to('USD')).to be_kind_of Rby::Money
      end

      it 'does not update the original account' do
        usd_money = euro_money.convert_to('USD')
        expect(euro_money.currency).to eq('EUR')
      end
    end
  end
end
