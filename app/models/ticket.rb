class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :status, :subject
  validates :body, :sender, :status, :subject, presence: true

  before_validation :set_defaults

  after_create :alert_users

  private

  def set_defaults
  	self.status = 'new' if self.status.blank?
  end

  def alert_users
  	UserMailer.new_ticket_created(self.id).deliver
  end
end
