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
  end

  # GET /games/1
  # GET /games/1.json
  def show
  end

  # GET /games/new
  # GET /games/new.json
  def new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    if @game.update_attributes(params[:game])
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy

    redirect_to games_url
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
