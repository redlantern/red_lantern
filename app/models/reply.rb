class Reply < ActiveRecord::Base
  belongs_to :ticket
  attr_accessible :body, :sender

  validates_presence_of :sender

  after_create :set_status

private

  def set_status
	  ticket.status = STATUS_WORK	
	  ticket.save!
  end

end
