class CustomerMailer < ActionMailer::Base
  default from: SENDER_CUSTOMER

  def new_reply_created reply_id
    @reply = Reply.find reply_id
    @ticket = @reply.ticket
    mail(to: @ticket.sender, subject: "[#{@ticket.id}] #{@ticket.subject}")

  end

end
