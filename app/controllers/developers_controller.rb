class DevelopersController < ApplicationController
  filter_resource_access

  # GET /developers
  # GET /developers.json
  def index
    @developers = Developer.with_permissions_to
  end

  # GET /developers/1
  # GET /developers/1.json
  def show
  end

  # GET /developers/new
  # GET /developers/new.json
  def new
  end

  # GET /developers/1/edit
  def edit
  end

  # POST /developers
  # POST /developers.json
  def create
    if @developer.save
      redirect_to @developer, notice: 'Developer was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /developers/1
  # PUT /developers/1.json
  def update
    options = {}
    options[:as] = :manager  if permitted_to? :update_address, @developer
    if @developer.update_attributes(params[:developer], options)
      redirect_to @developer, notice: 'Developer was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /developers/1
  # DELETE /developers/1.json
  def destroy
    @developer.destroy

    redirect_to developers_url
  end

protected

  def new_developer_from_params
    options = {}
    options[:as] = :manager  if permitted_to? :update_address, :developers

    @developer = Developer.new params[:developer], options
  end
end
