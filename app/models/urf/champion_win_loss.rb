module Urf
  class ChampionWinLoss
    include Mongoid::Document

    field :wins, type: Integer
    field :losses, type: Integer

    def total
      wins+losses
    end

    def ratio
      wins/total.to_f
    end

    has_one :champion
  end
end
