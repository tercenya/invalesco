class Mastery
  include Mongoid::Document

  field :masteryId, type: Integer
  field :rank, type: Integer
end
