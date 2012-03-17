require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test "should get index unauthenticated" do
    get :index
    assert_response :success
  end

  test "should see sign-in form when getting index unauthenticated" do
    get :index
    assert_select '#signin-form', 1
  end

  test "should get index authenticated" do
    sign_in Player.first
    get :index
    assert_response :redirect

    get :index
    assert_response :success
  end
end
