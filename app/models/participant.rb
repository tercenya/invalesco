class Participant
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  field :teamId, type: Integer
  field :championId, type: Integer
end
