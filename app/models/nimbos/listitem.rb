module Nimbos
  class Listitem < ActiveRecord::Base

	  def to_partial_path() 
	  	"nimbos/listheaders/listitem" 
	  end

	  belongs_to :listheader
	  
	  #attr_accessible :code, :i18n_code, :list_code, :name

	  Nimbos::Listheader.all.each do |header|
	  	scope "#{header.code}", -> { where(list_code: header.code) }
	  end
  end
end
