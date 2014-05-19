module Nimbos
  module CurrenciesHelper
	  def print_price(price, currency)
	  	"#{number_to_currency(price, precision: 2, locale: current_locale)} #{currency}" if price > 0
	  end
  end
end
