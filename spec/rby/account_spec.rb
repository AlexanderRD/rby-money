require 'spec_helper'

describe Rby::Account do
  let(:account) { Rby::Account.new(100, 'EUR') }
  let(:euro_money) { Rby::Money.new(10,'EUR') }
  let(:fourty_nine_euro) { Rby::Money.new(49,'EUR') }
  let(:fifty_euro) { Rby::Money.new(50,'EUR') }
  let(:fifty_one_euro) { Rby::Money.new(51,'EUR') }
  let(:twenty_dollars) { Rby::Money.new(20,'USD')}

  it 'responds to #amount with expected amount' do
    expect(account.amount).to eq 100
  end

  it 'responds to #currency with a String' do
    expect(account.currency).to be_kind_of(String)
  end

  it 'responds to #currency with expected currency' do
    expect(account.currency).to eq 'EUR'
  end

  it 'responds to #inspect with a String' do
    expect(account.inspect).to be_kind_of(String)
  end

  it 'responds to #inspect with the expected content' do
    expect(account.inspect).to eq('100.00 EUR')
  end

  context 'arithmetic methods' do
    before :each do
      Rby::Money.conversion_rates('EUR', {'USD' => 1.11} )
    end

    context '#+' do
      it 'responds with a Rby::Money object' do
        expect(fifty_euro + twenty_dollars).to be_kind_of Rby::Money
      end

      it 'responds with a new Rby::Money object with the original currency' do
        expect((fifty_euro + twenty_dollars).currency).to eq('EUR')
      end

      it 'responds with a new Rby::Money object with the expected amount' do
        expect((fifty_euro + twenty_dollars).amount).to eq 68.02
      end
    end

    context '#-' do
      it 'responds with a Rby::Money object' do
        expect(fifty_euro - twenty_dollars).to be_kind_of Rby::Money
      end

      it 'responds with a new Rby::Money object with the original currency' do
        expect((fifty_euro - twenty_dollars).currency).to eq('EUR')
      end

      it 'responds with a new Rby::Money object with the expected amount' do
        expect((fifty_euro - twenty_dollars).amount).to eq 31.98
      end
    end

    context '#/' do
      it 'responds with a Rby::Money object' do
        expect(fifty_euro / 2).to be_kind_of Rby::Money
      end

      it 'responds with a new Rby::Money object with the original currency' do
        expect((fifty_euro / 2).currency).to eq('EUR')
      end

      it 'responds with a new Rby::Money object with the expected amount' do
        expect((fifty_euro / 2).amount).to eq 25
      end
    end

    context '#*' do
      it 'responds with a Rby::Money object' do
        expect(fifty_euro * 3).to be_kind_of Rby::Money
      end

      it 'responds with a new Rby::Money object with the original currency' do
        expect((fifty_euro * 3).currency).to eq('EUR')
      end

      it 'responds with a new Rby::Money object with the expected amount' do
        expect((fifty_euro * 3).amount).to eq 150
      end
    end

    context '#==' do
      it 'responds with true when equal' do
        expect(fifty_euro.convert_to('USD') == fifty_euro).to be true
      end

      it 'responds with false result when inequal' do
        expect(fifty_one_euro.convert_to('USD') == fifty_euro).to be false
      end
    end

    context '#>' do
      it 'responds with true when greater' do
        expect(fifty_one_euro.convert_to('USD') > fifty_euro).to be true
      end

      it 'responds with false when smaller' do
        expect(fourty_nine_euro.convert_to('USD') > fifty_euro).to be false
      end
    end

    context '#<' do
      it 'responds with false when greater' do
        expect(fifty_one_euro.convert_to('USD') < fifty_euro).to be false
      end

      it 'responds with true when smaller' do
        expect(fourty_nine_euro.convert_to('USD') < fifty_euro).to be true
      end
    end
  end

end
