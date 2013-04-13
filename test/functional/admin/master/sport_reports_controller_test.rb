require 'test_helper'

class Admin::Master::SportReportsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
