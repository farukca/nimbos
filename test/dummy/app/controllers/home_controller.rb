class HomeController < ApplicationController

  layout 'nimbos/guest'

  def index
    if current_user && current_patron
      redirect_to user_path(current_user)
    else
      @betauser = Betauser.new
    end
  end

  def today
  end

  def air
  end

  def sea
  end

  def road
  end

  def rail
  end

  def inland
  end

  def roadmap
  end

  def security
  end

  def features
  end

  def services
  end

  def aboutus
    @feedback = Feedback.new
  end

end
