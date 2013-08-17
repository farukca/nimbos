module Nimbos
  class Currency < ActiveRecord::Base
    attr_accessible :code, :multiplier, :name, :symbol
  end
end
