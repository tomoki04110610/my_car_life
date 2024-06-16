require "test_helper"

class DrivingDistancesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get driving_distances_new_url
    assert_response :success
  end
end
