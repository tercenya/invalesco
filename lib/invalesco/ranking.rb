module Ranking
  def points(participant)
    case participant.tier
    when :unranked
      0
    when :bronze
      1
    when :silver
      2
    when :gold
      3
    when :platinum
      4
    when :diamond
      5
    when :challenger
      6
    when :master
      7
    else
      throw 'unknown tier'
    end
  end

  def team_points(participants)
    participants.map { |e| points(e) }.reduce(:+)
  end
end
