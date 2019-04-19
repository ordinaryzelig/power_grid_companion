class ResourceReplenishmentsController < ApplicationController

  def new
  end

  def create
    resource_replenishment = ResourceReplenishment.new(current_game)
    resource_replenishment.save!
    current_game.next_phase!
    redirect_to [:new, current_game.phase]
  end

end
