require 'test_helper'

class NimbosTest < ActiveSupport::TestCase
  test "user login" do

    visit nimbos.root_url
    fill_in 'Email', :with => 'test@nimbo.com.tr'
    fill_in 'Password', :with => '12345'
    click_button 'Login'

    success_message = 'Your have been logged in.'
    page.should have_content(success_message)

  end
end
