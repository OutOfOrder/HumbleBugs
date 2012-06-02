class NotesController < ApplicationController
  filter_resource_access :nested_in => :noteable
  # GET /:polymorphic/1/notes
  # GET /:polymorphic/1/notes.json
  def index
    @notes = @noteable.notes.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @notes }
    end
  end

  # GET /:polymorphic/1/notes/1
  # GET /:polymorphic/1/notes/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @note }
    end
  end

  # GET /:polymorphic/1/notes/new
  # GET /:polymorphic/1/notes/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @note }
    end
  end

  # GET /:polymorphic/1/notes/1/edit
  def edit
  end

  # POST /:polymorphic/1/notes
  # POST /:polymorphic/1/notes.json
  def create
    respond_to do |format|
      if @note.save
        format.html { redirect_to [@noteable, @note], notice: 'Note was successfully created.' }
        format.json { render json: @note, status: :created, location: @note }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /:polymorphic/1/notes/1
  # PUT /:polymorphic/1/notes/1.json
  def update
    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to [@noteable, @note], notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /:polymorphic/1/notes/1
  # DELETE /:polymorphic/1/notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.html { redirect_to [@noteable, Note] }
      format.json { head :no_content }
    end
  end

protected
  def load_noteable
    @noteable = find_polymorphic
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
