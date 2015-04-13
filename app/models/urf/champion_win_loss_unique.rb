module Urf
  class ChampionWinLossUnique
    include Mongoid::Document

    field :wins, type: Integer
    field :losses, type: Integer

    include Concerns::WinLoss
  end
end
