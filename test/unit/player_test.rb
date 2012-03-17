require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  ## should fail
  test "create empty player" do
    p = Player.new()
    assert !p.save
  end

  ## should fail
  test "create player without password" do
    p = Player.new(email: "test@example.com")
    assert !p.save
  end

  ## should succeed
  test "create player with email and password" do
    p = Player.new(email: "test@example.com", password: "12345678")
    assert p.save
  end

  ## should fail
  test "create player with existing email" do
    p = Player.new(email: "user1@example.com", password: "12345678")
    assert !p.save
  end
end
