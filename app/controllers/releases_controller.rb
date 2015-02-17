class ReleasesController < ApplicationController
  filter_resource_access :nested_in => :games, :shallow => true, :additional_member => :download

  # GET /games/1/releases
  # GET /games/1/releases.json
  def index
    @releases = @game.releases.with_permissions_to
  end

  def download
    Release.increment_counter :download_count, @release.id
    redirect_to @release.url
  end

  # GET /games/1/releases/1
  # GET /games/1/releases/1.json
  def show
  end

  # GET /games/1/releases/new
  # GET /games/1/releases/new.json
  def new
  end

  # GET /games/1/releases/1/edit
  def edit
  end

  # POST /games/1/releases
  # POST /games/1/releases.json
  def create
    if @release.save
      redirect_to game_url(@game, anchor:'game_releases'), notice: 'Release was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /games/1/releases/1
  # PUT /games/1/releases/1.json
  def update
    if @release.update_attributes(params[:release])
      redirect_to game_url(@release.game, anchor:'game_releases'), notice: 'Release was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /games/1/releases/1
  # DELETE /games/1/releases/1.json
  def destroy
    @release.destroy

    redirect_to game_url(@release.game, anchor:'game_releases')
  end

protected
  def new_release_from_params
    @release = @game.releases.build (params[:release] || {}).merge(:owner => current_user)
  end
end
