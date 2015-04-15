class Team
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :teamId, type: Integer
  field :winner, type: Boolean

  embeds_many :bans

  def winner?
    winner
  end
end
