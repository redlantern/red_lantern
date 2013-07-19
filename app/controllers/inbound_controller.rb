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

    reader = MailReader.new params

    if reader.is_reply?
      ticket = Ticket.find reader.ticket_id
      if create_replies ticket, reader.from, reader.body
        head :ok
      else
       head :internal_server_error # return http status 500 - internal server error 
      end
    else
      ticket = Ticket.new sender: reader.from, subject: reader.subject, body: reader.body
      if ticket.save
        head :ok # return http status 200 - ok
      else
        head :internal_server_error # return http status 500 - internal server error
      end
    end
  end

  private

  def create_replies ticket, sender, body
    actual_body = body.split(REPLY_ABOVE_THIS_LINE)[0]
    ticket.replies.create sender: sender, body: body
  end


end