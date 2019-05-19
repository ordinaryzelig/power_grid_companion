class Step3sController < ApplicationController

  def create
    current_game.step_3!
    redirect_to step3s_url
  end

end
