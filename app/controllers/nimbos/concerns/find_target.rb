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
	  elsif params[:lead_id]
	    return Logistics::Lead.find(params[:lead_id])
	  elsif params[:transport_id]
	    return Logistics::Transport.find(params[:transport_id])
	  elsif params[:company_id]
	    return Network::Company.find(params[:company_id])
	  elsif params[:vehicle_id]
	    return Fleet::Vehicle.find(params[:vehicle_id])
	  elsif params[:document_id]
	    return Arsiv::Document.find(params[:document_id])
	  elsif params[:post_id]
	  	return Nimbos::Post.find(params[:post_id])
	  elsif params[:task_id]
	    return Nimbos::Task.find(params[:task_id])
	  elsif params[:invoice_id]
	  	return Financor::Invoice.find(params[:invoice_id])
	  elsif params[:memo_id]
	  	return Messenger::Memo.find(params[:memo_id])
	  elsif params[:notice_id]
	  	return Network::Notice.find(params[:notice_id])
	  elsif params[:dispatch_id]
	  	return Arsiv::Dispatch.find(params[:dispatch_id])
	  elsif params[:driver_id]
	  	return Fleet::Driver.find(params[:driver_id])
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
