class SampleRecordsWorker
	
  @queue = :sample_records_queue

  def self.perform(patron_id)

  	@patron = Nimbos::Patron.find(patron_id)
  	@branch = @patron.branches.unscoped.first
  	@user   = @patron.users.first

  	create_company_and_contacts(patron_id)
  	@company = @patron.companies.unscoped.first
  	create_project_and_loadings(patron_id)
  	
  end

private
	def create_company_and_contacts(new_patron_id)

	  begin
	  	company = Network::Company.unscoped.find(1)
	  rescue ActiveRecord::RecordNotFound => e
	  	company = nil
	  end

	  unless company.nil?
	  	sample_company = company.dup
	  	sample_company.patron_id = @patron.id
	  	sample_company.branch_id = @branch.id
	  	sample_company.user_id   = @user.id
	  	sample_company.save

	  	company.contacts.unscoped.each do |contact|
	  		sample_contact = contact.dup
	  		sample_contact.company_id = sample_company.id
	  		sample_contact.patron_id  = @patron.id
	  		sample_contact.user_id    = @user.id
	  		sample_contact.save
	  	end

	  	unless company.financial.nil?
	  		sample_financial = company.financial.dup
	  		sample_financial.company_id = sample_company.id
	  		sample_financial.save
	  	end
	  end
	end

	def create_project_and_loadings(new_patron_id)
		begin
			position = Logistics::Position.unscoped.find(1)
		rescue ActiveRecord::RecordNotFound => e
			position = nil
		end

		unless position.nil?
			sample_position = position.dup
	  	sample_position.patron_id = @patron.id
	  	sample_position.branch_id = @branch.id
	  	sample_position.user_id   = @user.id
	  	sample_position.save
	  	position.loadings.each do |loading|
	  		sample_loading = loading.dup
  	  	sample_loading.patron_id  = @patron.id
	  	  sample_loading.branch_id  = @branch.id
	  	  sample_loading.company_id = @company.id
	  	  sample_loading.user_id    = @user.id
	  	  sample_loading.save


	  	end
		end
	end

end
