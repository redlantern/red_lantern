class UserMailer < ActionMailer::Base
  default to: SUPPORT_TEAM

  def new_ticket_created ticket_id
  	@ticket = Ticket.find ticket_id
    mail(from: sender_email_for(@ticket), subject: "Ticket ##{@ticket.id}: #{@ticket.subject}")
  end

  def new_reply_created ticket_id
    @ticket = Ticket.find ticket_id
    mail(from: sender_email_for(@ticket), subject: "Ticket ##{@ticket.id}: #{@ticket.subject}")
  end

  private

  def sender_email_for ticket
  	parts = SENDER_TICKET.split('@')
  	"#{parts[0]}+#{ticket.id}@#{parts[1]}"
  end
end
