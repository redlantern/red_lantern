class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :status, :subject
  validates :body, :sender, :status, :subject, presence: true

  before_validation :set_defaults

  private

  def set_defaults
  	self.status = 'new' if self.status.blank?
  end
end
