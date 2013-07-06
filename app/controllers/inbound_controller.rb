# new controller to receive data from Cloudmailin
# need to add route to hook it up
# e.g. /config/routes.rb
#
# match "/inbound" => "inbound#create"
# 402ad69ba37b07a1538b@cloudmailin.net

class InboundController < ApplicationController
  require 'mail'
  attr_reader :from, :subject, :body

  skip_before_filter :verify_authenticity_token
  SECRET = ENV['CLOUDMAILIN_SECRET'] || '24767c09641221bb0aca'

  def self.create #not sure if it should be a class method??
    # todo parse incoming mail
    # todo match mail to ticket
    # todo save ticket
    
    message = Mail.new(params[:message])
    self.new.map_mail

    # return head :ok to tell cloudmailin that we did everything successfully
    head :ok # return http status 200 - ok
  end

  def initialize
     @from = 'daphne@rails.com' #Rails.logger.info params[:headers]['From']
     @subject = 'Problem with app' #Rails.logger.info params[:headers]['Subject']
     @body = 'My app shuts down unexpectedly. Please fix it ASAP'#Rails.logger.info params[:plain]  
  end


private
  
    def map_mail
      #future enhancement: check if ticket exists, then update accordingly

      ticket = Ticket.new
      ticket.sender = from 
      ticket.subject = subject
      ticket.body = body
    end
    
end