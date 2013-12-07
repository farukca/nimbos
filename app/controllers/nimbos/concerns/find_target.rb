module Nimbos::Concerns::FindTarget
  extend ActiveSupport::Concern

private
	def find_target
	  if params[:ticket_id]
	    return Helpdesk::Ticket.find(params[:ticket_id])
	  elsif params[:ware_id]
      return Assetim::Ware.find(params[:ware_id])
    elsif params[:person_id]
      return Personal::Person.find(params[:person_id])
    elsif params[:discussion_id]
      return Nimbos::Discussion.find(params[:discussion_id])
	  elsif params[:position_id]
	    return Logistics::Position.find(params[:position_id])
	  elsif params[:loading_id]
	    return Logistics::Loading.find(params[:loading_id])
	  elsif params[:transport_id]
	    return Logistics::Transport.find(params[:transport_id])
	  elsif params[:document_id]
	    return Arsiv::Document.find(params[:document_id])
	  else
	    params.each do |name, value|
	      if name =~ /(.+)_id$/
	        return $1.classify.constantize.find(value)
	      end
	    end
	  end
	  nil
	end

end
