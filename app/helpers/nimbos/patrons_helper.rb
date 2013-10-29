module Nimbos
  module PatronsHelper

	  def patron_name(patron=@patron)
	  	patron.name
	  end

	  def patron_title(patron=@patron)
	  	patron.title
	  end

	  def patron_logo(patron = @patron)
	    cl_image_tag(patron.logo_url, width: 152, height: 60, crop: :fill, class: "media-object")
	  end

	  def patron_address(patron = @patron)
	  	"#{patron.address} #{patron.district}  #{patron.postcode}  #{patron.city} " << t("countries.#{patron.country_id}")
	  end

  end
end
