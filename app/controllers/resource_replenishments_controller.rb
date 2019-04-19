class ResourceReplenishmentsController < ApplicationController

  def new
    @resource_replenishment = ResourceReplenishment.new(current_game)
  end

  def create
    resource_replenishment = ResourceReplenishment.new(current_game)
    resource_replenishment.save!
  end

end
