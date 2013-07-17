class Reply < ActiveRecord::Base
  belongs_to :ticket
  attr_accessible :body, :sender

  after_create :set_status, :alert_users_replied

private

  def alert_users_replied
    CustomerMailer.new_reply_created(self.id).deliver
  	UserMailer.new_reply_created(ticket.id).deliver
  end

  def set_status
	ticket.status = STATUS_WORK	
	ticket.save!
  end

end
