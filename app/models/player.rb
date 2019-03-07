class Player < ApplicationRecord

  belongs_to :game
  include HasResources

  def purchase_resources(resources)
    self.class.transaction do
      update!(:balance => balance - resources.map(&:cost).reduce(:+))
      resources.each { |resource| resource.update!(:player => self, :market_space => nil) }
    end
  end

end
