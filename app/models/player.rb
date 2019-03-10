class Player < ApplicationRecord

  belongs_to :game
  has_resources :as => :owner

  scope :in_turn_order, -> { order(:turn_order) }
  scope :starting_with, -> (player) { where('turn_order >= ?', player.turn_order) }

  def purchase_resources(resources)
    self.class.transaction do
      update!(:balance => balance - resources.map(&:cost).reduce(:+))
      resources.each { |resource| resource.update!(:owner => self) }
    end
  end

end
