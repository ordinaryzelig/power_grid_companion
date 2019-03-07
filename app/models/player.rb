class Player < ApplicationRecord

  belongs_to :game
  has_resources :as => :owner

  def purchase_resources(resources)
    self.class.transaction do
      update!(:balance => balance - resources.map(&:cost).reduce(:+))
      resources.each { |resource| resource.update!(:owner => self) }
    end
  end

end
