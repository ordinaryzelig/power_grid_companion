class Game < ApplicationRecord

  has_many :players
  include HasResources
  has_many :resource_market_spaces

  before_validation :generate_token, :unless => :token

  def setup!
    Resource.setup!(self)
    ResourceMarketSpace.setup!(self)
    resources.map(&:resource_market_space_id)
  end

private

  def generate_token
    self.token = SecureRandom.hex(3)
  end

end
