class Reply < ActiveRecord::Base
  belongs_to :ticket
  attr_accessible :body, :sender

  after_create :set_status, :alert_users_replied

private

  def alert_users_replied
  	UserMailer.new_ticket_created(ticket.id).deliver
  end

  def set_status
	ticket.status = "Work in progress"	
	ticket.save!
  end

end
