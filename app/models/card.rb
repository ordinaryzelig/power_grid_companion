class Card < ApplicationRecord

  belongs_to :player, :optional => true

  include FlagShihTzu
  has_flags(
    1 => :step_3,
    2 => :coal,
    3 => :oil,
    4 => :uranium,
    5 => :trash,
    6 => :renewable,
    :column => 'kinds',
  )

  STANDARD_DECK = {
     3 => {:selected_kinds => [:oil],        :resources_required => 2, :cities => 1},
     4 => {:selected_kinds => [:coal],       :resources_required => 2, :cities => 1},
     5 => {:selected_kinds => [:coal, :oil], :resources_required => 2, :cities => 1},
     6 => {:selected_kinds => [:trash],      :resources_required => 1, :cities => 1},
     7 => {:selected_kinds => [:oil],        :resources_required => 3, :cities => 2},
     8 => {:selected_kinds => [:coal],       :resources_required => 3, :cities => 2},
     9 => {:selected_kinds => [:oil],        :resources_required => 1, :cities => 1},
    10 => {:selected_kinds => [:coal],       :resources_required => 2, :cities => 2},
    11 => {:selected_kinds => [:uranium],    :resources_required => 1, :cities => 2},
    12 => {:selected_kinds => [:coal, :oil], :resources_required => 2, :cities => 2},
    13 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 1},
    14 => {:selected_kinds => [:trash],      :resources_required => 2, :cities => 2},
    15 => {:selected_kinds => [:coal],       :resources_required => 2, :cities => 3},
    16 => {:selected_kinds => [:oil],        :resources_required => 2, :cities => 3},
    17 => {:selected_kinds => [:uranium],    :resources_required => 1, :cities => 2},
    18 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 2},
    19 => {:selected_kinds => [:trash],      :resources_required => 2, :cities => 3},
    20 => {:selected_kinds => [:coal],       :resources_required => 3, :cities => 5},
    21 => {:selected_kinds => [:coal, :oil], :resources_required => 2, :cities => 4},
    22 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 2},
    23 => {:selected_kinds => [:uranium],    :resources_required => 1, :cities => 3},
    24 => {:selected_kinds => [:trash],      :resources_required => 2, :cities => 4},
    25 => {:selected_kinds => [:coal],       :resources_required => 2, :cities => 5},
    26 => {:selected_kinds => [:oil],        :resources_required => 2, :cities => 5},
    27 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 3},
    28 => {:selected_kinds => [:uranium],    :resources_required => 1, :cities => 4},
    29 => {:selected_kinds => [:coal, :oil], :resources_required => 1, :cities => 4},
    30 => {:selected_kinds => [:trash],      :resources_required => 3, :cities => 6},
    31 => {:selected_kinds => [:coal],       :resources_required => 3, :cities => 6},
    32 => {:selected_kinds => [:oil],        :resources_required => 3, :cities => 6},
    33 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 4},
    34 => {:selected_kinds => [:uranium],    :resources_required => 1, :cities => 5},
    35 => {:selected_kinds => [:oil],        :resources_required => 1, :cities => 5},
    36 => {:selected_kinds => [:coal],       :resources_required => 3, :cities => 7},
    37 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 4},
    38 => {:selected_kinds => [:trash],      :resources_required => 3, :cities => 7},
    39 => {:selected_kinds => [:uranium],    :resources_required => 1, :cities => 6},
    40 => {:selected_kinds => [:oil],        :resources_required => 2, :cities => 6},
    42 => {:selected_kinds => [:coal],       :resources_required => 2, :cities => 6},
    44 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 5},
    46 => {:selected_kinds => [:coal, :oil], :resources_required => 3, :cities => 7},
    50 => {:selected_kinds => [:renewable],  :resources_required => 0, :cities => 6},
  }

  class << self

    def setup(game)
      game.cards.create!(:selected_kinds => [:step_3])
      STANDARD_DECK.each do |number, card_atts|
        game.cards.create!(card_atts.merge(:number => number))
      end
    end

  end

end
