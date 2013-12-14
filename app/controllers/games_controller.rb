class GamesController < ApplicationController
  filter_resource_access :nested_in => :bundles, :no_attribute_check => [:index]
  before_filter :only => :index do
    nested_check_with_attrs unless @bundle.nil?
  end

  # GET /games
  # GET /games.json
  def index
    if @bundle.nil?
      @games = Game.with_permissions_to.where(bundle_id: nil).order('games.name ASC')
      @bundles = Bundle.with_permissions_to.order('bundles.name ASC').includes(:games)
      @bundles.each do |bundle|
        @games -= bundle.games
      end
    else
      @games = @bundle.games.with_permissions_to
      @bundles = []
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

protected
  def load_bundle
    if params[:bundle_id]
      @bundle = Bundle.find(params[:bundle_id])
    else
      @bundle = nil
    end
  end

  def new_game_for_collection
    if @bundle.nil?
      @game = Game.new
    else
      @game = @bundle.games.new
    end
  end

  def new_game_from_params
    if @bundle.nil?
      @game = Game.new params[:game]
    else
      @game = @bundle.games.new params[:game]
    end
  end
end
