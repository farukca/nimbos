module Nimbos
  module CurrenciesHelper
	  def print_price(price, currency)
	  	"#{number_to_currency(price, precision: 2, unit: currency)}" #if price > 0 #, locale: current_locale
	  end
  end
end
