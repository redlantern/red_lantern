require 'spec_helper'

describe InboundController do


# three cases:
#  1. brand new email from customer
#  2. reply from support team
#  3. reply from customer


	describe "new email from customer" do

		context "successfully create a new ticket" do

			it "should return status 200" do
				# fake CloudMailin call
				post :create, {
					headers: {
						'To' => "support@laantern.com",
					  	'Subject' => "Having problems",
					  	'From' => "yiingshan@gmail.com"
					},
					plain: "My phone keeps freezing" #the email body as plain text
				}
				expect(response.status).to eq(200)
			end

			it "should create a new ticket" do
				expect { post :create, {
						headers: {
							'To' => "support@laantern.com",
						  	'Subject' => "Having problems",
						  	'From' => "yiingshan@gmail.com"
						},
						plain: "My phone keeps freezing" #the email body as plain text
					}
				}.to change{Ticket.count}.by(1)
			end

			it "delivers an email to the internal support team" do
				support_email = ActionMailer::Base.deliveries.last
				expect(support_email.to).to eq(["chris@codesoda.com", "yiingshan@gmail.com", "rachelle.lequesne@gmail.com"])
			end

		end

		context "unsuccessful ticket" do

			it "should return status 422" do
				# fake CloudMailin call
				post :create, {
					headers: {
						'To' => "support@laantern.com",
					  	'Subject' => "Having problems",
					  	'From' => ""
					},
					plain: "My phone keeps freezing" #the email body as plain text
				}
				expect(response.status).to eq(422)
			end

		end

	end

	describe "reply from suport team" do

		context "successful reply" do

			before do
				@ticket = Ticket.create(sender: "yiingshan@gmail.com", subject: "Having problems", body: "My phone keeps freezing", status: "New")

				# fake CloudMailin call
				post :create, {
					headers: {
						'To' => "ticket+#{@ticket.id}@laantern.com",
					  	'Subject' => "Having problems",
					  	'From' => "Rachelle.LeQuesne@gmail.com" #someone from the support team
					},
					plain: "please try to look into the logs" #the email body as plain text
				}
			end

			it "should return status 200" do
				expect(response.status).to eq(200)
			end

			it "should create a reply for the ticket" do
				# @ticket is a brand new ticket so any reply will be the first reply
				reply = @ticket.replies.first
				expect(reply.body).to eq("please try to look into the logs")
				expect(reply.sender).to eq("Rachelle.LeQuesne@gmail.com")
			end

			it "should deliver an email to both the customer and the support team" do
				# ActionMailer creates an array "ActionMailer::Base.deliveries" (see inbound_controller for the order in which they are created)
				support_email, customer_email = ActionMailer::Base.deliveries.last(2)
				expect(support_email.to).to eq(["chris@codesoda.com", "yiingshan@gmail.com", "rachelle.lequesne@gmail.com"])
				expect(customer_email.to).to eq(["yiingshan@gmail.com"])
			end
		end

		context "Unsuccessful Reply" do
			# generate an invalid reply
			before do
				@ticket = Ticket.create(sender: "yiingshan@gmail.com", subject: "Having problems", body: "My phone keeps freezing", status: "New")

				# fake CloudMailin call
				post :create, {
					headers: {
						'To' => "ticket+#{@ticket.id}@laantern.com",
					  	'Subject' => "Having problems",
					  	'From' => ""
					},
					plain: "please try to look into the logs"
				}
			end

			it "should return status 422" do
				expect(response.status).to eq(422)
			end

		end

	end

	describe "reply from customer" do

		context "reply creation successful" do

			before do
				@ticket = Ticket.create(sender: "yiingshan@gmail.com", subject: "Having problems", body: "My phone keeps freezing", status: "New")

				# fake CloudMailin call
				post :create, {
					headers: {
						'To' => "support@laantern.com",
					  	'Subject' => "[#{@ticket.id}] Having problems",
					  	'From' => "yiingshan@gmail.com" #customer
					},
					plain: "Thank you for your help" #the email body as plain text
				}
			end

			it "should return status 200" do
				expect(response.status).to eq(200)
			end

			it "should create a reply to ticket" do
				# @ticket is a brand new ticket so any reply will be the first reply
				reply = @ticket.replies.last
				expect(reply.body).to eq("Thank you for your help")
				expect(reply.sender).to eq("yiingshan@gmail.com")
			end

			it "should deliver an email to support team" do
				# ActionMailer creates an array "ActionMailer::Base.deliveries" (see inbound_controller for the order in which they are created)
				support_email = ActionMailer::Base.deliveries.last
				expect(support_email.to).to eq(["chris@codesoda.com", "yiingshan@gmail.com", "rachelle.lequesne@gmail.com"])
			end

		end

		context "reply creation unsuccessful" do

			before do
				@ticket = Ticket.create(sender: "yiingshan@gmail.com", subject: "Having problems", body: "My phone keeps freezing", status: "New")

				# fake CloudMailin call
				post :create, {
					headers: {
						'To' => "support@laantern.com",
					  	'Subject' => "[#{@ticket.id}] Having problems",
					  	'From' => "" #customer
					},
					plain: " " #the email body as plain text
				}
			end

			it "should return status 422" do
				expect(response.status).to eq(422)
			end

			it "should not send an email to the internal support team" do
				# UserMailer should not execute :new_reply_created

			end

		end

	end

end
