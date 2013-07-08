class UserMailer < ActionMailer::Base
  default from: SENDER,
  			to: SUPPORT_TEAM

  def new_ticket_created ticket_id

  	@ticket = Ticket.find ticket_id
    #@user = 'yiingshan@gmail.com'
    #@url = 'http://example.com/login'
    mail(subject: "Ticket ##{ticket_id}: #{@ticket.subject}")

  end
end
