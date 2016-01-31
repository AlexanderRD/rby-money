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
      if other.is_a? Rby::Money
        Rby::Money.new(amount + other.convert_to(currency).amount, currency)
      else
        raise_coercion_error(other, 'Rby::Money')
      end
    end

    def -(other)
      if other.is_a? Rby::Money
        Rby::Money.new(amount - other.convert_to(currency).amount, currency)
      else
        raise_coercion_error(other, 'Rby::Money')
      end
    end

    def /(other)
      if other.is_a? Numeric
        Rby::Money.new(amount / other, currency)
      else
        raise_coercion_error(other, 'Numeric')
      end
    end

    def *(other)
      if other.is_a? Numeric
        Rby::Money.new(amount * other, currency)
      else
        raise_coercion_error(other, 'Numeric')
      end
    end

    def ==(other)
      if other.is_a? Rby::Money
        converted_other = other.convert_to(currency)
        (amount == converted_other.amount) && (currency == converted_other.currency)
      else
        raise_coercion_error(other, 'Rby::Money')
      end
    end

    def >(other)
      if other.is_a? Rby::Money
        amount > other.convert_to(currency).amount
      else
        raise_coercion_error(other, 'Rby::Money')
      end
    end

    def <(other)
      if other.is_a? Rby::Money
        amount < other.convert_to(currency).amount
      else
        raise_coercion_error(other, 'Rby::Money')
      end
    end

    private

    def raise_coercion_error other, type
      raise TypeError, "#{other.class} can't be coerced into #{type}"
    end
  end
end
