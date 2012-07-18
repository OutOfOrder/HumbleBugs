class ReleasesController < ApplicationController
  filter_resource_access :nested_in => :games

  # GET /games/1/releases
  # GET /games/1/releases.json
  def index
    @releases = @game.releases.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @releases }
    end
  end

  # GET /games/1/releases/1
  # GET /games/1/releases/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release }
    end
  end

  # GET /games/1/releases/new
  # GET /games/1/releases/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @release }
    end
  end

  # GET /games/1/releases/1/edit
  def edit
  end

  # POST /games/1/releases
  # POST /games/1/releases.json
  def create
    respond_to do |format|
      if @release.save
        format.html { redirect_to @game, notice: 'Release was successfully created.' }
        format.json { render json: @release, status: :created, location: @release }
      else
        format.html { render action: "new" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1/releases/1
  # PUT /games/1/releases/1.json
  def update
    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to @game, notice: 'Release was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1/releases/1
  # DELETE /games/1/releases/1.json
  def destroy
    @release.destroy

    respond_to do |format|
      format.html { redirect_to game_releases_url(@game) }
      format.json { head :no_content }
    end
  end

protected
  def new_release_from_params
    @release = @game.releases.build (params[:release] || {}).merge(:owner => current_user)
  end
end
