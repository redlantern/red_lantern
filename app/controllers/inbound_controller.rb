# new controller to receive data from Cloudmailin
# need to add route to hook it up
# e.g. /config/routes.rb
#
# match "/inbound" => "inbound#create"
# 402ad69ba37b07a1538b@cloudmailin.net

class InboundController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create
    Rails.logger.info params.inspect

    # sender1 = "Ticket+70@redlantern.com"
    # if sender1.start_with?("Ticket")

    if params[:headers]['From'].start_with?("Ticket")
      get_ticket_id(params[:headers]['From'])
      # get_ticket_id(sender1)
      @ticket = Ticket.find @ticket_id
      create_replies(@ticket.sender,@ticket.body)

    else
      ticket = Ticket.new(
        sender: params[:headers]['From'], 
        subject: params[:headers]['Subject'], 
        body: params[:plain]
      )
       
       begin
        ticket.save
        head :ok # return http status 200 - ok
       rescue StandardError=>e
        head :internal_server_error # return http status 500 - internal server error
       end

    end

  end

  private

  def create_replies(sender,body)
    begin
      @ticket.replies.create(sender: @ticket.sender, body: @ticket.body)
      head :ok
    rescue StandardError=>e
    end
  end

  def get_ticket_id sender
    partial = sender.split('@').first
    @ticket_id = partial.split('+').last

  end

    
end