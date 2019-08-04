class ResourceTransfer

  def initialize(player, params)
    @player = player
    @resources = @player.resources.find(MultiJson.load(params.fetch(:resource_ids)))
    @card      = @player.cards.find(params.fetch(:card_id))
  end

  def save!
    ActiveRecord::Base.transaction do
      raise 'Not enough space' unless @card.resource_vacancies >= @resources.size
      raise 'Incorrect resource kind' unless resource_kinds & @card.selected_kinds == resource_kinds
      @resources.each do |resource|
        resource.move_to @card
      end
    end
  end

private

  def resource_kinds
    @resource_kinds = @resources.map(&:kind).uniq.map(&:to_sym)
  end

end
