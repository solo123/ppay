require 'test_helper'

class UploadDataControllerTest < ActionController::TestCase
  test "should get import" do
    get :import
    assert_response :success
  end

end
