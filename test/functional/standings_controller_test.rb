require 'test_helper'

class StandingsControllerTest < ActionController::TestCase
  setup do
    @standing = standings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:standings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create standing" do
    assert_difference('Standing.count') do
      post :create, standing: @standing.attributes
    end

    assert_redirected_to standing_path(assigns(:standing))
  end

  test "should show standing" do
    get :show, id: @standing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @standing
    assert_response :success
  end

  test "should update standing" do
    put :update, id: @standing, standing: @standing.attributes
    assert_redirected_to standing_path(assigns(:standing))
  end

  test "should destroy standing" do
    assert_difference('Standing.count', -1) do
      delete :destroy, id: @standing
    end

    assert_redirected_to standings_path
  end
end
