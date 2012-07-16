require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    user = FactoryGirl.create(:user, password_reset_token: 'testtoken')
    let(:mail) { UserMailer.password_reset(user) }

    it "renders the headers" do
      mail.subject.should eq("Reset your HumbleBugs account password")
      mail.to.should eq([user.email])
      mail.from.should eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("/forgot_password/testtoken")
    end
  end

  describe "confirm_account" do
    user = FactoryGirl.create(:user, confirm_account_token: 'testtoken')
    let(:mail) { UserMailer.confirm_account(user) }

    it "renders the headers" do
      mail.subject.should eq("Confirm your HumbleBugs account")
      mail.to.should eq([user.email])
      mail.from.should eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("/confirm_account/testtoken")
    end
  end
end
