require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  test "should not create empty player" do
    p = Player.new()
    assert !p.save
  end

  test "should not create player without password" do
    p = Player.new(email: "test@example.com")
    assert !p.save
  end

  test "should create player with email and password" do
    p = Player.new(email: "test@example.com", password: "12345678")
    assert p.save
  end

  test "should not create player with existing email" do
    p = Player.new(email: "user1@example.com", password: "12345678")
    assert !p.save
  end

  test "should have a rating of 1300 when creating a new player" do
    p = Player.new(email: "test@example.com", password: "12345678")
    p.save

    assert p.ratings.last.value == 1300
  end
end
