class CommentsController < ApplicationController
  filter_resource_access :nested_in => :commentable

  # GET /:polymorphic/1/comments/1
  # GET /:polymorphic/1/comments/1.json
  def show
    respond_to do |format|
      format.js # show.js.erb
      format.json { render json: @comment }
    end
  end

  # GET /:polymorphic/1/comments/new
  # GET /:polymorphic/1/comments/new.json
  def new
    respond_to do |format|
      format.js # new.js.erb
      format.json { render json: @comment }
    end
  end

  # GET /:polymorphic/1/comments/1/edit
  def edit
  end

  # POST /:polymorphic/1/comments
  # POST /:polymorphic/1/comments.json
  def create
    respond_to do |format|
      if @comment.save
        format.js
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.js { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /:polymorphic/1/comments/1
  # PUT /:polymorphic/1/comments/1.json
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.js { render action: "show" }
        format.json { head :no_content }
      else
        format.js { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /:polymorphic/1/comments/1
  # DELETE /:polymorphic/1/comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.js # destroy.js.erb
      format.json { head :no_content }
    end
  end

protected
  def load_commentable
    @commentable = find_polymorphic [:issue]
  end

  def new_comment_from_params
    @comment = @commentable.comments.build (params[:comment] || {}).merge(:author => current_user)
  end
end
