class IssueMailer < ActionMailer::Base
  def new_issue(issue)
    @issue = issue

    recipients = issue.game.ports.map {|p| p.porter.email}.uniq

    mail bcc: recipients
  end
end
