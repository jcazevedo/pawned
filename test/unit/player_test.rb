require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "should not create empty player" do
    p = Player.new()
    assert !p.save
  end

  test "should not create player with only email" do
    p = Player.new(email: "test@example.com")
    assert !p.save
  end

  test "should not create player with only email and password" do
    p = Player.new(email: "test@example.com", password: "12345678")
    assert !p.save
  end

  test "should create player with email, username and password" do
    p = Player.new(email: "test@example.com", password: "12345678", username: "test")
    assert p.save
  end

  test "should not create player with existing email" do
    p = Player.new(email: "user1@example.com", password: "12345678", username: "test")
    assert !p.save
  end

  test "should not create player with existing username" do
    p = Player.new(email: "test@example.com", password: "12345678", username: "user1")
    assert !p.save
  end

  test "should have a rating of 1300 when creating a new player" do
    p = Player.new(email: "test@example.com", password: "12345678", username: "test")
    p.save

    assert_equal p.ratings.last.value, 1300
  end
end
