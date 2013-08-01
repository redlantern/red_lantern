
class InboundController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create

    reader = MailReader.new params
<<<<<<< HEAD
    if reader.is_internal_reply? || reader.is_customer_reply?
=======
    if reader.is_internal_reply?
>>>>>>> master
      ticket = Ticket.find reader.ticket_id
      reply_ticket_status ticket, reader.from, reader.body
    else
      new_ticket_status reader.from, reader.subject, reader.body
    end
    
  end


  private

    def reply_ticket_status ticket, from, body 
      if create_replies ticket, from, body
        head :ok
      else
       head :internal_server_error # return http status 500 - internal server error 
      end
<<<<<<< HEAD
    end

    def new_ticket_status from, subject, body
      ticket = Ticket.new sender: from, subject: subject, body: body
      if ticket.save
        head :ok # return http status 200 - ok
=======
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
>>>>>>> master
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

    def create_replies ticket, sender, body
      # this is messy! Needs tidying up...
      just_reply_part = body.split(REPLY_ABOVE_THIS_LINE)[0]
      only_reply = just_reply_part.split(/On.*wrote:/).first
      # line_by_line = just_reply_part.split("\n")
      # actual_body = line_by_line[0..line_by_line.length-5].join("\n")
      ticket.replies.create sender: sender, body: only_reply
    end
end