class AuctionsController < ApplicationController

  before_action :set_auction, :only => %i[show bid pass claim]
  before_action :check_auction_in_progress, :only => %i[new]
  after_action  :broadcast_auction_updated, :only => %i[bid pass claim]
  after_action  :broadcast_markets_updated, :only => %i[create claim pass]

  def new
    @auction = current_game.auctions.new
  end

  def create
    auction_atts = auction_params.merge(
      :player_id => current_player.id,
      :round     => current_game.round,
    )
    @auction = current_game.auctions.create!(auction_atts)
    @auction.bid_by current_player
    redirect_to @auction
  end

  def show
  end

  def bid
    @auction.bid_by current_player
    head :ok
  end

  def pass
    @auction.pass_by current_player
    head :ok
  end

  def claim
    card_to_replace = current_game.cards.find(params[:card_to_replace_id]) if params[:card_to_replace_id]
    @auction.claim(card_to_replace)
    current_game.cards.draw_deck.shuffle! if current_game.cards.last_drawn&.step_3?
    next_player_or_next_phase
  end

  def skip
    current_game.remove_phase_player(current_player)
    current_game.cards.market.first.remove! if current_game.all_players_skipped_auction?
    next_player_or_next_phase
  end

private

  def auction_params
    params
      .require(:auction)
      .permit(
        :card_id,
      )
  end

  def set_auction
    @auction = current_game.auctions.find(params[:id])
  end

  def broadcast_auction_updated
    current_game.players.each do |player|
      html = render_to_string(
        :template => 'auctions/show',
        :layout   => false,
        :locals   => {
          :@auction       => @auction,
          :current_player => player,
          :direct_render  => true,
        },
      )
      PlayersChannel.replace(player, [
        {
          :dom_id => "#auction_#{@auction.id}",
          :html   => html,
        },
      ])
    end
  end

  def broadcast_markets_updated
    replacements = %w[actual future].map do |market_type|
      dom_id = ".power_plant_market.#{market_type}"
      html =
        render_to_string(
          :template => 'auctions/_market',
          :layout   => false,
          :locals   => {
            :cards       => current_game.cards.send("#{market_type}_market"),
            :market_type => market_type,
            :auction     => @auction,
          },
        )
      {
        :dom_id => dom_id,
        :html   => html,
      }
    end
    current_game.players.each do |player|
      PlayersChannel.replace player, replacements
    end
  end

  def check_auction_in_progress
    if auction = current_game.auctions.reverse.detect(&:open?)
      redirect_to auction_url(auction)
    end
  end

end
