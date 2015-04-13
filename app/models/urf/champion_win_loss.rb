module Urf
  class ChampionWinLoss
    include Mongoid::Document

    field :wins, type: Integer
    field :losses, type: Integer

    include Concerns::WinLoss
  end
end