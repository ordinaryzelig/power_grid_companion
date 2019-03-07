module HasResources

  def self.included(model)
    model.instance_eval do
      has_many :resources
      Resource.kinds.keys.each do |kind|
        has_many kind.pluralize.to_sym, -> { Resource.send(kind) }, :class_name => 'Resource'
      end
    end
  end

  def resources_of_kind(kind)
    Resource.kinds.fetch(kind.to_s) # guard
    send(kind.to_s.pluralize)
  end

end
