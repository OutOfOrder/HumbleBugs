class PredefinedTagsController < ApplicationController
  filter_resource_access :additional_collection => {:complete => :read}

  # GET /predefined_tags
  # GET /predefined_tags.json
  def index
    @predefined_tags = PredefinedTag.with_permissions_to
  end

  # GET /predefined_tags/platforms.json
  def complete
    t = PredefinedTag.arel_table
    @predefined_tags = PredefinedTag.with_permissions_to.
        where(context: params[:context]).
        where(t[:name].matches("#{params[:term]}%"))

    respond_to do |format|
      format.html { render :index }
      format.json { render json: @predefined_tags.map { |m|
        m.name
      } }
    end
  end

  # GET /predefined_tags/1
  # GET /predefined_tags/1.json
  def show
  end

  # GET /predefined_tags/new
  # GET /predefined_tags/new.json
  def new
  end

  # GET /predefined_tags/1/edit
  def edit
  end

  # POST /predefined_tags
  # POST /predefined_tags.json
  def create
    if @predefined_tag.save
      redirect_to @predefined_tag, notice: 'Predefined tag was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /predefined_tags/1
  # PUT /predefined_tags/1.json
  def update
    if @predefined_tag.update_attributes(params[:predefined_tag])
      redirect_to @predefined_tag, notice: 'Predefined tag was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /predefined_tags/1
  # DELETE /predefined_tags/1.json
  def destroy
    @predefined_tag.destroy

    redirect_to predefined_tags_url
  end
end
