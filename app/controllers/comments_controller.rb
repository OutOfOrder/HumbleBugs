class CommentsController < ApplicationController
  filter_resource_access :nested_in => :commentable
  # GET /:polymorphic/1/comments
  # GET /:polymorphic/1/comments.json
  def index
    @comments = @commentable.comments.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /:polymorphic/1/comments/1
  # GET /:polymorphic/1/comments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /:polymorphic/1/comments/new
  # GET /:polymorphic/1/comments/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
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
        format.html { redirect_to [@commentable, @comment], notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /:polymorphic/1/comments/1
  # PUT /:polymorphic/1/comments/1.json
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to [@commentable, @comment], notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /:polymorphic/1/comments/1
  # DELETE /:polymorphic/1/comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to [@commentable, Comment] }
      format.json { head :no_content }
    end
  end

protected
  def load_commentable
    @commentable = find_polymorphic
  end

private
  def find_polymorphic
    params.each do |name, value|
      if name.ends_with?("_id")
        return name[0..-4].classify.constantize.find(value)
      end
    end
    nil
  end
end
