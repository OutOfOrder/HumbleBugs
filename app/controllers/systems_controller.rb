class SystemsController < ApplicationController
  filter_resource_access :nested_in => :users

  # GET /systems
  # GET /systems.json
  def index
    @systems = @user.systems.with_permissions_to
  end

  # GET /systems/1
  # GET /systems/1.json
  def show
  end

  # GET /systems/new
  # GET /systems/new.json
  def new
  end

  # GET /systems/1/edit
  def edit
  end

  # POST /systems
  # POST /systems.json
  def create
    if @system.save
      redirect_to @user, notice: 'System was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /systems/1
  # PUT /systems/1.json
  def update
    if @system.update_attributes(params[:system])
      redirect_to @user, notice: 'System was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /systems/1
  # DELETE /systems/1.json
  def destroy
    @system.destroy

    redirect_to [@user]
  end
end
