require 'test_helper'

class UploadReportControllerTest < ActionController::TestCase
  test "should get upload" do
    get :upload
    assert_response :success
  end

  test "should get check" do
    get :check
    assert_response :success
  end

end
