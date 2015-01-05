require "spec_helper"

describe IssueMailer do
  describe "new_issue" do
    it "renders the headers" do
      game = FactoryGirl.create :game, :with_developer
      issue = FactoryGirl.create(:issue, game: game)
      mail = IssueMailer.new_issue(issue)
      expect(mail.subject).to eq("New HumbleBugs issue")
      expect(mail.from).to eq(["myfromaddress@example.com"])
    end

    it 'should email all developers for the associated game' do
      game = FactoryGirl.create :game, :with_developer
      issue = FactoryGirl.create :issue, game: game
      mail = IssueMailer.new_issue(issue)
      expect(mail.bcc).to eq(game.developer.users.map &:email)
    end

    it 'should email all porters for the associated game' do
      port = FactoryGirl.create :port
      FactoryGirl.create :user, roles:[:user], developer: port.developer
      issue = FactoryGirl.create :issue, game: port.game
      mail = IssueMailer.new_issue(issue)
      expect(mail.bcc).to eq(port.developer.users.map &:email)
    end
  end

  describe "new_comment" do
    it "renders the headers" do
      comment = FactoryGirl.create(:comment)
      mail = IssueMailer.new_comment(comment)
      expect(mail.subject).to eq("New HumbleBugs comment")
      expect(mail.from).to eq(["myfromaddress@example.com"])
    end

    it 'should email all developers for the associated game' do
      developer = FactoryGirl.create :developer
      user = FactoryGirl.create :user, developer: developer
      game = FactoryGirl.create :game, developer: developer
      issue = FactoryGirl.create :issue, game: game
      comment = FactoryGirl.create :comment, commentable: issue
      mail = IssueMailer.new_comment(comment)
      expect(mail.bcc).to match_array([user.email, issue.author.email, comment.author.email])
    end

    it 'should email all porters for the associated game' do
      port = FactoryGirl.create :port
      issue = FactoryGirl.create :issue, game: port.game
      comment = FactoryGirl.create :comment, commentable: issue
      mail = IssueMailer.new_comment(comment)
      expect(mail.bcc).to match_array([*port.developer.users.map(&:email), issue.author.email, comment.author.email])
    end

    it 'should filter out myself' do
      issue = FactoryGirl.create :issue
      comment = FactoryGirl.create :comment, commentable: issue
      with_user issue.author do
        mail = IssueMailer.new_comment(comment)
        expect(mail.bcc).to match_array([comment.author.email])
      end
    end
  end
end
