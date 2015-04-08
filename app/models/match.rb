class Match
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :matchId, type: Integer
  field :region, type: String
  field :queueType, type: String

  embeds_many :teams
  embeds_many :participants
end
