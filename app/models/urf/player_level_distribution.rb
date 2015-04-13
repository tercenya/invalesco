module Urf
  class PlayerLevelDistribution
    include Mongoid::Document

    field :count, type: Integer
  end
end
