# new controller to receive data from Cloudmailin
# need to add route to hook it up
# e.g. /config/routes.rb
#
# match "/inbound" => "inbound#create"
# 402ad69ba37b07a1538b@cloudmailin.net

class InboundController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create #not sure if it should be a class method??
    Rails.logger.info params.inspect
binding.pry
    if params[:headers]['From'].start_with?("Ticket")
      get_ticket_id(params[:headers]['From'])
      ticket = Ticket.find @ticket_id
      ticket.replies.create(sender: ticket.sender, body: ticket.body)

    else
      ticket = Ticket.new(
        sender: params[:headers]['From'], 
        subject: params[:headers]['Subject'], 
        body: params[:plain]
      )
    
        if ticket.save
          head :ok # return http status 200 - ok
        else
          Rails.logger.info ticket.errors.inspect
          head :internal_server_error # return http status 500 - internal server error
        end
    end

    private

    def get_ticket_id sender
      partial = sender.split('@')[0]
      @ticket_id = partial.split('+')[1]

    end

  end

    
end