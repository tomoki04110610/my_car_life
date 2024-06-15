require "test_helper"

class CarModelsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get car_models_new_url
    assert_response :success
  end

  test "should get index" do
    get car_models_index_url
    assert_response :success
  end

  test "should get show" do
    get car_models_show_url
    assert_response :success
  end

  test "should get edit" do
    get car_models_edit_url
    assert_response :success
  end
end
