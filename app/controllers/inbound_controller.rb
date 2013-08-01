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
    if reader.is_internal_reply?
      ticket = Ticket.find reader.ticket_id
      if create_replies ticket, reader.from, reader.body
        head :ok
      else
       head :internal_server_error # return http status 500 - internal server error 
      end
    else
      # email is from a customer
      if reader.ticket_id.nil?
        # this is a brand-new email from the customer so create a new ticket
        ticket = Ticket.new sender: reader.from, subject: reader.subject, body: reader.body
        if ticket.save
          head :ok # return http status 200 - ok
        else
          head :internal_server_error # return http status 500 - internal server error
        end
      else
        # this email is a reply to an existing ticket so create a reply
        ticket = Ticket.find reader.ticket_id
        if create_replies ticket, reader.from, reader.body
          head :ok
        else
          head :internal_server_error # return http status 500 - internal server error 
        end
      end
    end
  end

  private

  def create_replies ticket, sender, body
    # this is messy! Needs tidying up...
    just_reply_part = body.split(REPLY_ABOVE_THIS_LINE)[0]
    only_reply = just_reply_part.split(/On.*wrote:/).first
    # line_by_line = just_reply_part.split("\n")
    # actual_body = line_by_line[0..line_by_line.length-5].join("\n")
    ticket.replies.create sender: sender, body: only_reply
  end


end