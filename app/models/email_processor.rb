class EmailProcessor
	def self.processor(email)
		new(email).process
	end

	def initialize(email)
		put "this is the email #{email}"
		@email = email
	end

	def process
		Ticket.create(sender: email.from, body: email.body)
	end
end
