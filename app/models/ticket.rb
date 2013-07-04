class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :status, :subject
  validates :body, :sender, :status, :subject , presence: true
end
