require "spec_helper"

describe FeedbackMailer do
  describe "submit_feedback" do
    before do
      @user = FactoryGirl.create(:user)
      @feedback = FactoryGirl.build(:feedback)
      @mail = FeedbackMailer.submit_feedback(@user, @feedback)
    end

    it "renders the headers" do
      expect(@mail.subject).to match(/Feedback/)
      expect(@mail.to).to eq(['feedback@example.com'])
      expect(@mail.from).to eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match(user_path(@user))
    end
  end

end
