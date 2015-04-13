class Champion
  include Mongoid::Document
  # include Mongoid::Attributes::Dynamic

  @@all = []
  @@cache = {}

  field :key, type: String
  field :name, type: String
  field :title, type: String
  field :_id, type: Integer, default: ->{ id }


  def self.find(id)
    return @@cache[id] ||= super(id) if id.is_a?(Integer)
    super
  end
end	
