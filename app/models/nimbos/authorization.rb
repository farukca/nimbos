module Nimbos
  class Authorization < ActiveRecord::Base

    belongs_to :user

	  validates  :controller, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user_id }


    default_scope { where(patron_id: Nimbos::Patron.current_id) }
  end
end
