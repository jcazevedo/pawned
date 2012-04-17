require 'test_helper'

class DuelTest < ActiveSupport::TestCase
  test "destroying a duel should delete all its matches" do
    d = duels(:poor_strife_round_one_duel_one)
    m_ids = d.matches.map{ |m| m.id }

    d.destroy

    m_ids.each do |m|
      assert !Match.exists?(m)
    end
  end
end
