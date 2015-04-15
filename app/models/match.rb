class Match
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :matchId, type: Integer
  field :region, type: String
  field :queueType, type: String

  embeds_many :teams
  embeds_many :participants

  def blue_team
    teams[0]
  end

  def red_team
    teams[1]
  end

  def blue_participants
    #participants.where(teamId: 100)
    # optimization: blue team is always the first 5
    participants[0..4]
  end

  def red_participants
    # participants.where(teamId: 200)
    participants[5..9]
  end

  # you can't call .team.participants, but this is close
  def team_participants
    [red_participants, blue_participants]
  end

  def champions
    participants.map(&:champion)
  end

  def blue_characters
    blue_participants.map(&:champion)
  end

  def red_characters
    red_participants.map(&:champion)
  end

  def winner
    blue_team.winner ? :blue : :red
  end

  def combined_levels
    participants.map(&:estimated_level).reduce(:+)
  end
end
