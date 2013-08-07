class CustomerMailer < ActionMailer::Base
  default from: SENDER_CUSTOMER

  def new_reply_created ticket_id

  	@ticket = Ticket.find(ticket_id)
    @reply = @ticket.replies.last

    mail(to: @ticket.sender, subject: "[#{@ticket.id}] #{@ticket.subject}")

  end

end
