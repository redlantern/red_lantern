class UserMailer < ActionMailer::Base
  default from: "support@redlantern.com"

  def new_ticket_created ticket_id

  	@ticket = Ticket.find ticket_id
    #@user = 'yiingshan@gmail.com'
    #@url = 'http://example.com/login'
    mail(to: 'yiingshan@gmail.com, chris@codesoda.com, rachelle.lequesne@gmail.com', subject: "Ticket ##{ticket_id}: #{@ticket.subject}")

  end
end
