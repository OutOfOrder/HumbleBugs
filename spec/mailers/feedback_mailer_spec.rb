require "spec_helper"

describe FeedbackMailer do
  describe "submit_feedback" do
    user = FactoryGirl.create(:user)
    feedback = FactoryGirl.build(:feedback)
    let(:mail) { FeedbackMailer.submit_feedback(user, feedback) }

    it "renders the headers" do
      mail.subject.should eq("HumbleBugs feedback")
      mail.to.should eq(['feedback@example.com'])
      mail.from.should eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match(user_path(user))
    end
  end

end
