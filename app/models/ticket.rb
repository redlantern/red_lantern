class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :status, :subject
end
