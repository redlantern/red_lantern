class MailReader

	def initialize params = {}
		@params = params
	end

	def to
		@params[:headers]['To']
	end

	def from
		@params[:headers]['From']
	end

	def subject
		@params[:headers]['Subject']
	end

	def body
 		@params[:plain]
 	end


	def is_reply?
	  recipient = to
	  if match = recipient.match(/<(.+)>/)
	    recipient = match[1]
	  end
	  ticket_account,ticket_domain = SENDER_TICKET.downcase.split("@")
	  account,domain = recipient.downcase.split('@')
	  account.split("+").first == ticket_account && domain == ticket_domain
	end

	def ticket_id
	  if is_reply?
		  partial = to.split('@').first
		  partial.split('+').last.to_i
	  end
	end

end