module HasResources

  def self.extended(model)
    model.instance_eval do
      def has_resources(options = {})
        has_many :resources, options
        Resource.kinds.keys.each do |kind|
          has_many kind.pluralize.to_sym, -> { Resource.send(kind) }, :class_name => 'Resource', **options
        end
      end
    end
    model.include InstanceMethods
  end

  module InstanceMethods

    def resources_of_kind(kind)
      Resource.kinds.fetch(kind.to_s) # guard
      send(kind.to_s.pluralize)
    end

  end

end
