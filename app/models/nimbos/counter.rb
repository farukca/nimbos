module Nimbos
  class Counter < ActiveRecord::Base

    #attr_accessible :confirmed, :count, :counter_type, :period, :prefix, :suffix

	  validates :counter_type, presence: true
	  validates :count, numericality: { only_integer: true }
	  #validates :prefix, presence: true, :if => Proc.new { |a| a.operation.present? }

	  default_scope { where(patron_id: Nimbos::Patron.current_id) }
	  
	  def get_reference
	    strRef = ""
	    strRef << self.prefix if self.prefix
	    strRef << sprintf('%07d', self.count)
	    strRef << self.suffix if self.suffix
	    return strRef.upcase
	  end

  end
end
