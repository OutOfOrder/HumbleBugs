module CommentsHelper
  def new_form
    render 'form'
  end

  def edit_form
    render 'form'
  end

  def commentable_actions(commentable, comment, is_new)
    render file: "/comments/actions/#{commentable.class.table_name}",
           locals: {
               commentable: commentable,
               comment: comment,
               is_new: is_new
           }
  rescue ActionView::MissingTemplate => ex
    Rails.logger.error ex
    nil
  end
end
