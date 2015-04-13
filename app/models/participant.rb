class Participant
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  embeds_many :masteries

  field :teamId, type: Integer
  field :championId, type: Integer

  def champion
    Champion.find(championId)
  end

  def winner?
    stats['winner']
  end

  def tier
    highestAchievedSeasonTier.downcase.to_sym
  end

  # use mastery page to estimate the player's level
  def estimated_level
    # @NOTE: odd assuption:
    #  if your mastery page was entirely blank, we're going to guess level 30.
    return 30 if masteries.empty?

    masteries.map(&:rank).reduce(:+)
  end
end
