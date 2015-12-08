require 'test_helper'

class UploadReportControllerTest < ActionController::TestCase
  test "should get import" do
    get :import
    assert_response :success
  end

  test "should get check" do
    get :check
    assert_response :success
  end

end
