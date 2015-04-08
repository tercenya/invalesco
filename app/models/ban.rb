class Ban
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :championId, type: Integer
  field :pickTurn, type: Integer
end
