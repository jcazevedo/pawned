require 'test_helper'

class RoundTest < ActiveSupport::TestCase
  test "destroying a round should destroy all its duels" do
    r = rounds(:poor_strife_round_one)
    d_ids = r.duels.map{ |d| d.id }

    r.destroy

    d_ids.each do |d|
      assert !Duel.exists?(d)
    end
  end
end
