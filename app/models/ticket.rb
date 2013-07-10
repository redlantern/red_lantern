class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :status, :subject

  has_many :replies

  validates :body, :sender, :status, :subject, presence: true

  before_validation :set_defaults

  after_create :alert_users_create
  after_update :alert_users_update

  private

  def set_defaults
  	self.status = 'new' if self.status.blank?
  end

  def alert_users_create
  	UserMailer.new_ticket_created(self.id).deliver
  end

  def alert_users_update
    UserMailer.ticket_updated(self.id).deliver
  end
end
