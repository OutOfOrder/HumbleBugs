class ReleasesController < ApplicationController
  before_filter :load_game

  # GET /games/1/releases
  # GET /games/1/releases.json
  def index
    @releases = @game.releases

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @releases }
    end
  end

  # GET /games/1/releases/1
  # GET /games/1/releases/1.json
  def show
    @release = @game.releases.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release }
    end
  end

  # GET /games/1/releases/new
  # GET /games/1/releases/new.json
  def new
    @release = @game.releases.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @release }
    end
  end

  # GET /games/1/releases/1/edit
  def edit
    @release = @game.releases.find(params[:id])
  end

  # POST /games/1/releases
  # POST /games/1/releases.json
  def create
    @release = @game.releases.build(params[:release])

    respond_to do |format|
      if @release.save
        format.html { redirect_to [@game, @release], notice: 'Release was successfully created.' }
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
    @release = @game.releases.find(params[:id])

    respond_to do |format|
      if @release.update_attributes(params[:release])
        format.html { redirect_to [@game, @release], notice: 'Release was successfully updated.' }
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
    @release = Release.find(params[:id])
    @release.destroy

    respond_to do |format|
      format.html { redirect_to game_releases_url(@game) }
      format.json { head :no_content }
    end
  end

  private
    def load_game
      @game = Game.find(params[:game_id])
    end
end
