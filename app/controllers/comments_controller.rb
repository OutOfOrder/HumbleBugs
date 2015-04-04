class CommentsController < ApplicationController
  filter_resource_access :nested_in => :commentable

  # GET /:polymorphic/1/comments/1
  # GET /:polymorphic/1/comments/1.json
  def show
  end

  # GET /:polymorphic/1/comments/new
  # GET /:polymorphic/1/comments/new.json
  def new
  end

  # GET /:polymorphic/1/comments/1/edit
  def edit
  end

  # POST /:polymorphic/1/comments
  # POST /:polymorphic/1/comments.json
  def create
    if @comment.save
      @reload = false
      if params[:commentable]
        @commentable.update_attributes(params[:commentable])
        @reload = true
      end
      render
      if @commentable.is_a?(Issue)
        begin
          IssueMailer.new_comment(@comment).deliver
        rescue NoRecipientsException
        end
      end
    else
      render action: "error"
    end
  end

  # PUT /:polymorphic/1/comments/1
  # PUT /:polymorphic/1/comments/1.json
  def update
    if @comment.update_attributes(params[:comment])
      render action: "show"
    else
      render action: "edit"
    end
  end

  # DELETE /:polymorphic/1/comments/1
  # DELETE /:polymorphic/1/comments/1.json
  def destroy
    @comment.destroy
  end

protected
  def load_commentable
    @commentable = find_polymorphic [:issue]
  end

  def new_comment_from_params
    @comment = @commentable.comments.build (params[:comment] || {}).merge(:author => current_user)
  end
end
