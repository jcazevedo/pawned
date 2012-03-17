require 'test_helper'

class Admin::PlayersControllerTest < ActionController::TestCase
  test "should get index unanthenticated" do
    get :index
    assert_response :redirect
  end

  test "should get show unanthenticated" do
    get :show
    assert_response :redirect
  end

  test "should get new unanthenticated" do
    get :new
    assert_response :redirect
  end

  test "should get create unanthenticated" do
    get :create
    assert_response :redirect
  end

  test "should get edit unanthenticated" do
    get :edit
    assert_response :redirect
  end

  test "should get update unanthenticated" do
    get :update
    assert_response :redirect
  end

  test "should get destroy unanthenticated" do
    get :destroy
    assert_response :redirect
  end

end
