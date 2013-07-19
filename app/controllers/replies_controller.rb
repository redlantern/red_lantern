class RepliesController < ApplicationController
	def create

		ticket = Ticket.find(session[:id])
	    replies = ticket.replies.build(params[:reply])

	    respond_to do |format|
	      if replies.save!
	      	#can't redirect to @ticket
	        format.html { redirect_to ticket, notice: 'Reply sent.' }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @ticket.errors, status: :unprocessable_entity }
	      end
	    end
	end

end
