module Nimbos
  class Currency < ActiveRecord::Base
    set_primary_key = 'code'
    
    attr_accessible :code, :multiplier, :name, :symbol
  end
end
