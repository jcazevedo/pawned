require 'test_helper'

class TournamentPlayersControllerTest < ActionController::TestCase
  setup do
    @tournament_player = tournament_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tournament_players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tournament_player" do
    assert_difference('TournamentPlayer.count') do
      post :create, tournament_player: @tournament_player.attributes
    end

    assert_redirected_to tournament_player_path(assigns(:tournament_player))
  end

  test "should show tournament_player" do
    get :show, id: @tournament_player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tournament_player
    assert_response :success
  end

  test "should update tournament_player" do
    put :update, id: @tournament_player, tournament_player: @tournament_player.attributes
    assert_redirected_to tournament_player_path(assigns(:tournament_player))
  end

  test "should destroy tournament_player" do
    assert_difference('TournamentPlayer.count', -1) do
      delete :destroy, id: @tournament_player
    end

    assert_redirected_to tournament_players_path
  end
end
