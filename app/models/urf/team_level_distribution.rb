module Urf
  class TeamLevelDistribution
    include Mongoid::Document

    field :count, type: Integer
  end
end
