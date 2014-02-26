require 'test_helper'

class LoginTest < ActiveDispatch::Integration

	before { visit nimbos.login_url }

  describe "user login test" do

    fill_in 'Email', :with => 'farukca@mynet.com'
    fill_in 'Password', :with => '123456'

    click_button 'Login'

    success_message = 'Your have been logged in.'
    page.should have_content(success_message)

  end

end