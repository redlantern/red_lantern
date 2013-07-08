# new controller to receive data from Cloudmailin
# need to add route to hook it up
# e.g. /config/routes.rb
#
# match "/inbound" => "inbound#create"
# 402ad69ba37b07a1538b@cloudmailin.net

class InboundController < ApplicationController
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create #not sure if it should be a class method??
    Rails.logger.info params.inspect

    # parse incoming mail    
    # message = Mail.new(params[:message])
    ticket = Ticket.new(
      sender: params[:headers]['From'], 
      subject: params[:headers]['Subject'], 
      body: params[:plain]
    )
    
    # todo match mail to ticket
    # save ticket
    if ticket.save
      head :ok # return http status 200 - ok
    else
      Rails.logger.info ticket.errors.inspect
      head :internal_server_error # return http status 500 - internal server error
    end
  end

    
end