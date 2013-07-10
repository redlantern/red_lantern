class Reply < ActiveRecord::Base
  belongs_to :ticket
  attr_accessible :body, :sender
end
