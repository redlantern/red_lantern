class Ticket < ActiveRecord::Base
  attr_accessible :body, :sender, :subject
end
