module RubyMoney
  class Converter
    attr_accessor :base_currency,
                  :currency_hash

    def initialize(base_currency=nil, currency_hash={})
      configure_rates(base_currency, currency_hash)
    end

    def configure_rates(base_currency, currency_hash={})
      @base_currency = base_currency
      @currency_hash = currency_hash
    end

    def determine_amount(account, target_currency)
      return if account.nil? || target_currency.nil?
      return account.amount if account.currency == target_currency
      return unless currency_defined?(target_currency)

      current_rate = rate_for_currency(account.currency)
      target_rate = rate_for_currency(target_currency)

      (account.amount * target_rate).fdiv(current_rate)
    end

    private

    def currency_defined? currency_name
      currency_hash.has_key? currency_name
    end

    def rate_for_currency currency_name
      return 1 if currency_name == base_currency
      currency_hash.fetch(currency_name, nil)
    end
  end
end
