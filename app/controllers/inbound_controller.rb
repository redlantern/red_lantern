
class InboundController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create

    reader = MailReader.new params

    ticket = nil
    if reader.ticket_id
      ticket = Ticket.find reader.ticket_id
      
      if reader.is_internal_reply? && User.valid_user?(reader.from_email)
      
        if reply_ticket_status ticket, reader.from, reader.body
          UserMailer.new_reply_created(ticket.id).deliver
          CustomerMailer.new_reply_created(ticket.id).deliver
        end

      elsif reader.is_customer_reply? && ticket.is_from?(reader.from_email)
        
        if reply_ticket_status ticket, reader.from, reader.body
          UserMailer.new_reply_created(ticket.id).deliver
        end

      else
        # Rails.logger.debug("ignoring...")
        spam_ticket reader
      end

    else

      new_ticket_status reader.from, reader.subject, reader.body

    end
    
  end


  private

    def reply_ticket_status ticket, from, body 
      reply = create_replies ticket, from, body

      if reply.valid?
        head :ok
      else
        head :unprocessable_entity # return http status 422
      end

    end

    def new_ticket_status from, subject, body
      ticket = Ticket.new sender: from, subject: subject, body: body
      if ticket.save
        head :ok # return http status 200 - ok
      else
        head :unprocessable_entity # return http status 422
      end
    end

    def create_replies ticket, sender, body
      # this is messy! Needs tidying up...

      unless body.nil?
        just_reply_part = body.split(REPLY_ABOVE_THIS_LINE)[0]
        only_reply = just_reply_part.split(/On.*wrote:/).first
        # line_by_line = just_reply_part.split("\n")
        # actual_body = line_by_line[0..line_by_line.length-5].join("\n")
      end
      ticket.replies.create sender: sender, body: only_reply
    end

    def spam_ticket reader
      head :not_implemented
    end
end