module Rby
  class Converter
    attr_accessor :currency_hash

    def initialize(base_currency=nil, currency_hash={})
      configure_rates(base_currency, currency_hash)
    end

    def configure_rates(base_currency, currency_hash={})
      @currency_hash = currency_hash.merge({ base_currency => 1 })
    end

    def determine_amount(account, target_currency)
      return if account.nil? || target_currency.nil?
      return account.amount if account.currency == target_currency
      return unless currency_defined?(target_currency)

      current_rate = rate_for_currency(account.currency)
      target_rate = rate_for_currency(target_currency)

      (account.amount * target_rate).fdiv(current_rate).round(2)
    end

    private

    def currency_defined? currency_name
      currency_hash.has_key? currency_name
    end

    def rate_for_currency currency_name
      currency_hash.fetch(currency_name, nil)
    end
  end
end
