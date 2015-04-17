module Urf
  class ChampionWinLoss
    include Mongoid::Document

    field :wins, type: Integer
    field :losses, type: Integer
    field :played, type: Integer  #matches is an invalid field name

    include Concerns::WinLoss
  end
end
