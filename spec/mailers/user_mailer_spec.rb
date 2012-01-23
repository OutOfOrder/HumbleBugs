require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    user = FactoryGirl.create(:user, password_reset_token: 'testtoken')
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("/forgot_password/testtoken")
    end
  end

end
