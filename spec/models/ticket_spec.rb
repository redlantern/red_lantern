require 'spec_helper'

describe Ticket do
#let(:ticket){ create(:ticket) }
let(:valid_attributes) { { sender: "chris@codesoda.com", } }

  it { should validate_presence_of(:sender) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:body) }
  it { should respond_to(:status) }

  it { should have_many(:replies) }


describe "#alert_users_create" do
	it "calls the user mailer to deliver email with ticket id" do
		# UserMailer.stub(:new_ticket_created)
		# UserMailer.should_receive(:new_ticket_created).with(ticket.id)
		UserMailer.new_ticket_created(ticket.id)
		ActionMailer::Base.deliveries.size.should == 1
	end
end


end
