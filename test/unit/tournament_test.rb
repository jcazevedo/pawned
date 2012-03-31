require 'test_helper'

class TournamentTest < ActiveSupport::TestCase
  test "should not create an empty tournament " do
    t = Tournament.new()
    assert !t.save
  end

  test "should not create a tournament without date_started or status" do
    t = Tournament.new(:name => "The evil bulge")
    assert !t.save
  end

  test "should not create a tournament without status" do
    t = Tournament.new(:name => "The evil bulge", :date_started => Date.today)
    assert !t.save
  end

  test "should not create a tournament with an existing name" do
    t = Tournament.new(:name => "The Huge Bulge", :date_started => Date.today)
    assert !t.save
  end
end
