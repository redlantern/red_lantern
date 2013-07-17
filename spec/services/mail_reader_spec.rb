require 'spec_helper'

describe MailReader do

let(:to) { "support@laantern.com" }
let(:from) { "yiingshan@gmail.com" }
let(:subject) { "subject" }
let(:body) { "body" }
let(:params)do
	{ 
		headers: { 
			'To' => to,
			'From' => from,
			'Subject' => subject
		}, 
		plain: body

	}
end

let(:reader){ MailReader.new params }

 it "can be instantiated" do
	reader.should_not be_nil
 end	

 context "data" do
 	it "returns the from" do
 		reader.from.should == from 
 	end

 	it "returns the subject" do
 		reader.subject.should == subject
 	end

 	it "returns the body" do
 		reader.body.should == body
 	end

 	it "returns to" do
 		reader.to.should == to
 	end
 end

 context "logic" do
 	it "should identify when it is not a reply" do
 		reader.is_reply?.should be_false
 	end

 	it "should identify when it is a reply" do
 		params[:headers]['To'] = "ticket+10@laantern.com"
 		reader.is_reply?.should be_true
 	end

 	it "should identify when it is a reply from email with name" do
 		params[:headers]['To'] = "Rachelle LeQuesne <ticket+10@laantern.com>"
 		reader.is_reply?.should be_true 		
 	end

 	it "should return nil ticket id if it is not a reply" do
 		reader.ticket_id.should be_nil
 	end

 	it "should return a ticket id if it is a reply" do
 		params[:headers]['To'] = "ticket+10@laantern.com" 		
 		reader.ticket_id.should eq(10)
 	end

 end


end
