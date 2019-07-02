class ResourcePurchasesController < ApplicationController

  before_action :set_turn

  def new
    @resource_purchase = ResourcePurchase.new(current_player, {})
  end

  def create
    resource_purchase = ResourcePurchase.new(current_player, resource_purchase_params)
    resource_purchase.save!
    current_game.remove_phase_player(current_player)

    current_game.broadcast
    resources_str = resource_purchase.resources.group_by(&:kind).map do |kind, resources|
      "#{resources.size} #{kind.pluralize(resources.size)}"
    end.join(', ')
    current_game.broadcast_log "#{current_player.name} bought #{resources_str} for #{resource_purchase.cost}€."

    next_player_or_next_phase
  end

  def pass
    current_game.remove_phase_player(current_player)
    next_player_or_next_phase
  end

private

  def resource_purchase_params
    params
      .require(:resource_purchase)
      .permit(
        :coal,
        :oil,
        :uranium,
        :trash,
      )
  end

  def set_turn
    @your_turn = current_game_player == current_player
  end

end
