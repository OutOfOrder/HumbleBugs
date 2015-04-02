class IssueMailer < ActionMailer::Base
  def new_issue(issue)
    @issue = issue

    recipients = []
    @issue.game.ports.where('ports.developer_id IS NOT NULL').includes(:developer).each do |p|
      recipients.push *p.developer.users.map(&:email)
    end
    if @issue.game.developer.present?
      recipients.push *@issue.game.developer.users.map(&:email)
    end
    recipients.uniq!
    recipients.compact!
    # Filter out my own email
    if Authorization.current_user.is_a?(User)
      recipients.select! { |e| e != Authorization.current_user.email }
    end

    if recipients.blank?
      raise NoRecipientsException.new
    end
    mail bcc: recipients,
        subject: default_i18n_subject(summary: @issue.summary, issue_id: @issue.id)
  end

  def new_comment(comment)
    @issue = comment.commentable
    @comment = comment

    recipients = []
    recipients.push @issue.author.try(:email)
    recipients.push *@issue.comments.includes(:author).map {|c| c.author.try(:email)}
    @issue.game.ports.where('ports.developer_id IS NOT NULL').includes(:developer).each do |p|
      recipients.push *p.developer.users.map(&:email)
    end
    if @issue.game.developer.present?
      recipients.push *@issue.game.developer.users.map(&:email)
    end
    recipients.uniq!
    recipients.compact!
    # Filter out my own email
    if Authorization.current_user.is_a?(User)
      recipients.select! { |e| e != Authorization.current_user.email }
    end

    if recipients.blank?
      raise NoRecipientsException.new
    end
    mail bcc: recipients,
         subject: default_i18n_subject(summary: @issue.summary, issue_id: @issue.id)
  end
end