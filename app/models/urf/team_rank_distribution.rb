module Urf
  class TeamRankDistribution
    include Mongoid::Document
    include Mongoid::Attributes::Dynamic

    field :wins, type: Integer
    field :losses, type: Integer

    include Concerns::WinLoss
  end
end
