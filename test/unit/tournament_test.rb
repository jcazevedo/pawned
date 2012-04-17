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

  test "should create a tournament without status" do
    t = Tournament.new(:name => "The evil bulge", :date_started => Date.today)
    assert t.save
  end

  test "destroying a tournament should destroy all its rounds" do
    t = tournaments(:poor_strife)
    r_ids = t.rounds.map{ |r| r.id }

    t.destroy

    r_ids.each do |r|
      assert !Round.exists?(r)
    end
  end
end
