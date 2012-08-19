class IssueMailer < ActionMailer::Base
  def new_issue(issue)
    @issue = issue

    recipients = issue.game.ports.includes(:porter).map {|p| p.porter.email}.uniq

    mail bcc: recipients
  end

  def new_comment(comment)
    @issue = comment.commentable
    @comment = comment

    recipients = []
    recipients.push @issue.author.email
    recipients.push *@issue.comments.includes(:author).map {|c| c.author.email}
    recipients.push *@issue.game.ports.includes(:porter).map {|p| p.porter.email}
    recipients.uniq!
    # Filter out my own email
    recipients.select! { |e| e != Authorization.current_user.email }

    mail bcc: recipients
  end
end