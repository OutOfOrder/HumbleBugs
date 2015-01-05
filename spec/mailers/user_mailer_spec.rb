require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    before do
      @user = FactoryGirl.create(:user, password_reset_token: 'testtoken')
      @mail = UserMailer.password_reset(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("Reset your HumbleBugs account password")
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("/forgot_password/testtoken")
    end
  end

  describe "confirm_account" do
    before do
      @user = FactoryGirl.create(:user, confirm_account_token: 'testtoken')
      @mail = UserMailer.confirm_account(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("Confirm your HumbleBugs account")
      expect(@mail.to).to eq([@user.email])
      expect(@mail.from).to eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("/confirm_account/testtoken")
    end
  end

  describe "new_account" do
    before do
      @user = FactoryGirl.create(:user, confirm_account_token: 'testtoken')
      @mail = UserMailer.new_account(@user)
    end

    it "renders the headers" do
      expect(@mail.subject).to eq("New HumbleBugs account registered")
      expect(@mail.to).to eq(['feedback@example.com'])
      expect(@mail.from).to eq(["myfromaddress@example.com"])
    end

    it "renders the body" do
      expect(@mail.body.encoded).to match("/users/#{@user.id}")
    end
  end
end
