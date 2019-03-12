require 'test_helper'

class ResourceReplenishmentsController < ApplicationController

  def create
    resource_replenishment = ResourceReplenishment.new(current_game)
    resource_replenishment.save!
  end

end
