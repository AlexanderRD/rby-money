module Rby
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

    def +(other)
      raise_coercion_error(other, 'Rby::Money') unless other.is_a? Rby::Money
      Rby::Money.new(amount + other.convert_to(currency).amount, currency)
    end

    def -(other)
      raise_coercion_error(other, 'Rby::Money') unless other.is_a? Rby::Money
      Rby::Money.new(amount - other.convert_to(currency).amount, currency)
    end

    def /(other)
      raise_coercion_error(other, 'Numeric') unless other.is_a? Numeric
      Rby::Money.new(amount.fdiv(other), currency)
    end

    def *(other)
      raise_coercion_error(other, 'Numeric') unless other.is_a? Numeric
      Rby::Money.new(amount * other, currency)
    end

    def ==(other)
      raise_coercion_error(other, 'Rby::Money') unless other.is_a? Rby::Money

      amount == other.convert_to(currency).amount
    end

    def >(other)
      raise_coercion_error(other, 'Rby::Money') unless other.is_a? Rby::Money
      amount > other.convert_to(currency).amount
    end

    def <(other)
      raise_coercion_error(other, 'Rby::Money') unless other.is_a? Rby::Money
      amount < other.convert_to(currency).amount
    end

    private

    def raise_coercion_error other, type
      raise TypeError, "#{other.class} can't be coerced into #{type}"
    end
  end
end
