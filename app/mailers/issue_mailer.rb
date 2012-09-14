class IssueMailer < ActionMailer::Base
  def new_issue(issue)
    @issue = issue

    recipients = issue.game.ports.includes(:porter).map {|p| p.porter.email}
    if @issue.game.developer.present?
      recipients.push *@issue.game.developer.users.map {|u| u.email }
    end
    recipients.uniq!
    # Filter out my own email
    if Authorization.current_user.is_a?(User)
      recipients.select! { |e| e != Authorization.current_user.email }
    end

    if recipients.blank?
      raise NoRecipientsException.new
    end
    mail bcc: recipients
  end

  def new_comment(comment)
    @issue = comment.commentable
    @comment = comment

    recipients = []
    recipients.push @issue.author.email
    recipients.push *@issue.comments.includes(:author).map {|c| c.author.email}
    recipients.push *@issue.game.ports.includes(:porter).map {|p| p.porter.email}
    if @issue.game.developer.present?
      recipients.push *@issue.game.developer.users.map {|u| u.email }
    end
    recipients.uniq!
    # Filter out my own email
    if Authorization.current_user.is_a?(User)
      recipients.select! { |e| e != Authorization.current_user.email }
    end

    if recipients.blank?
      raise NoRecipientsException.new
    end
    mail bcc: recipients
  end
end