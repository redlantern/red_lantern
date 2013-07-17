require "spec_helper"

describe CustomerMailer do
  describe "new_reply_created" do
    let(:mail) { CustomerMailer.new_reply_created }

    it "renders the headers" do
      mail.subject.should eq("New reply created")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
