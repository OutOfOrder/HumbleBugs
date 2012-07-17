class SystemsController < ApplicationController
  filter_resource_access :nested_in => :users

  # GET /systems
  # GET /systems.json
  def index
    @systems = @user.systems.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @systems }
    end
  end

  # GET /systems/1
  # GET /systems/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @system }
    end
  end

  # GET /systems/new
  # GET /systems/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @system }
    end
  end

  # GET /systems/1/edit
  def edit
  end

  # POST /systems
  # POST /systems.json
  def create
    respond_to do |format|
      if @system.save
        format.html { redirect_to @user, notice: 'System was successfully created.' }
        format.json { render json: @system, status: :created, location: @system }
      else
        format.html { render action: "new" }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /systems/1
  # PUT /systems/1.json
  def update
    respond_to do |format|
      if @system.update_attributes(params[:system])
        format.html { redirect_to @user, notice: 'System was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /systems/1
  # DELETE /systems/1.json
  def destroy
    @system.destroy

    respond_to do |format|
      format.html { redirect_to [@user] }
      format.json { head :no_content }
    end
  end
end
