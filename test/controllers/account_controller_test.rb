require 'test_helper'

class AccountControllerTest < ActionDispatch::IntegrationTest
  test "should get mypins" do
    get account_mypins_url
    assert_response :success
  end

end
