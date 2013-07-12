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

    #sender1 = "Ticket+70@laantern.com"
    #if sender1.start_with?("Ticket")

    sender, subject, body = extract_params

    if is_reply? sender
      ticket_id = get_ticket_id sender
      # get_ticket_id(sender1)
      ticket = Ticket.find ticket_id
      if create_replies ticket
        head :ok
      else
       head :internal_server_error # return http status 500 - internal server error 
      end
    else
      ticket = Ticket.new sender: sender, subject: subject, body: body
      if ticket.save
        head :ok # return http status 200 - ok
      else
        head :internal_server_error # return http status 500 - internal server error
      end
    end
  end

  private

  def extract_params
    [ params[:headers]['From'],
      params[:headers]['Subject'],
      params[:plain] ]
  end

  def is_reply? sender
    if match = sender.match(/(?:<(.+)>)/)
      sender = match[1]
    end
    ticket_account,ticket_domain = SENDER_TICKET.downcase.split("@")
    account,domain = sender.downcase.split('@')
    #raise "#{ticket_account} = #{account}, #{ticket_domain} = #{domain}"
    account.split("+").first == ticket_account && domain == ticket_domain
  end

  def create_replies ticket
    ticket.replies.create sender: ticket.sender, body: ticket.body
  end

  def get_ticket_id sender
    partial = sender.split('@').first
    partial.split('+').last
  end

end