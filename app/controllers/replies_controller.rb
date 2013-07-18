class RepliesController < ApplicationController
	def create
		@ticket = Ticket.find(params[:id])
	    @replies = @ticket.replies

	    respond_to do |format|
	      if @replies.save
	        format.html 
	        format.json { render json: @ticket }
	      else
	        format.html { render action: "new" }
	        format.json { render json: @ticket.errors, status: :unprocessable_entity }
	      end
	    end
	end

	def new
		
	end
end
