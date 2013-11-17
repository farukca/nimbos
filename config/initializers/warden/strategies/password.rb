Warden::Strategies.add(:password) do

  def valid?
		params["user"]["email"] && params["user"]["password"]
	end

	def authenticate!
		u = Nimbos::User.find_by_email(params["user"]["email"])
		if u.nil? || (u.user_status != "active")
			fail!
		else
			if u.authenticate(params["user"]["password"])
				success!(u)
			else
				fail!
			end
		end
	end

end
