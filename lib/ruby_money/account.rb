module RubyMoney
  class Account
    attr_reader :amount,
                :currency

    def initialize(amount, currency)
      @amount = amount
      @currency = currency
    end

    def inspect
      "#{format('%.2f', amount)} #{currency}"
    end
  end
end
