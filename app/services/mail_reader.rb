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


	def is_internal_reply?
	  recipient = to

	  if match = recipient.match(/<(.+)>/)
	    recipient = match[1]
	  end
	  ticket_account,ticket_domain = SENDER_TICKET.downcase.split("@")
	  account,domain = recipient.downcase.split('@')
	  account.split("+").first == ticket_account && domain == ticket_domain
	end

	def ticket_id
	  if is_internal_reply?
		  partial = to.split('@').first
		  partial.split('+').last.to_i
	  else
	  	 match = subject.match(/\[([0-9]+)\]/)
	  	 match[1]
	  end
<<<<<<< HEAD

	end

	def is_customer_reply?
		  if subject.match(/\[([0-9]+)\]/).nil?
		  	false
		  else
		  	true
		  end
=======
>>>>>>> master
	end

end