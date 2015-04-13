module Concerns
  module WinLoss
    def total
      wins+losses
    end

    def ratio
      wins/total.to_f
    end

    def champion
      Champion.find(_id)
    end
  end
end
