require 'ruby_money/converter.rb'
require 'ruby_money/account.rb'

module Ruby
  class Money
    @@converter = RubyMoney::Converter.new

    extend Forwardable
    attr_reader :account
    def_delegators :@account, :inspect, :currency, :amount


    def self.conversion_rates base_currency, currency_hash={}
      @@converter.configure_rates(base_currency, currency_hash)
    end

    def initialize(amount, currency)
      @account = RubyMoney::Account.new(amount, currency)
    end

    def convert_to delta_currency
      delta_amount = @@converter.determine_amount(account, delta_currency)
      self.class.new(delta_amount, delta_currency)
    end
  end
end
