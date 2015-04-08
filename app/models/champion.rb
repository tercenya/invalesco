class Champion
  include Mongoid::Document
  # include Mongoid::Attributes::Dynamic

  field :key, type: String
  field :name, type: String
  field :title, type: String
  field :_id, type: Integer, default: ->{ id }
end
