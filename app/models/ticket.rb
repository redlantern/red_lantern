class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :status, :subject

  has_many :replies

  validates :body, :sender, :status, presence: true

  before_validation :set_defaults

  after_create :alert_users_create

  def is_from? email
    sender_email = sender
    if match = sender_email.match(/<(.+)>/)
      sender_email = match[1]
    end
    sender_email == email
  end

  private

  def set_defaults
  	self.status = STATUS_NEW if self.status.blank?
  end

  def alert_users_create
  	UserMailer.new_ticket_created(self.id).deliver
  end

end
