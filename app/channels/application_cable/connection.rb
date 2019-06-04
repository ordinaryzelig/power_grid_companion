module ApplicationCable
  class Connection < ActionCable::Connection::Base

    identified_by :current_player

    include AuthHelper

    def connect
      self.current_player = find_current_player || reject_unauthorized_connection
    end

  end
end
