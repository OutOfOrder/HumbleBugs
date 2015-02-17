class PortsController < ApplicationController
  filter_resource_access :nested_in => :games

  # GET /games/1/ports
  # GET /games/1/ports.json
  def index
    @ports = @game.ports.with_permissions_to
  end

  # GET /games/1/ports/1
  # GET /games/1/ports/1.json
  def show
  end

  # GET /games/1/ports/new
  # GET /games/1/ports/new.json
  def new
  end

  # GET /games/1/ports/1/edit
  def edit
    @port = @game.ports.find(params[:id])
  end

  # POST /games/1/ports
  # POST /games/1/ports.json
  def create
    @port = @game.ports.new(params[:port])

    if @port.save
      redirect_to @game, notice: 'Port was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /games/1/ports/1
  # PUT /games/1/ports/1.json
  def update
    @port = @game.ports.find(params[:id])

    if @port.update_attributes(params[:port])
      redirect_to @game, notice: 'Port was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /games/1/ports/1
  # DELETE /games/1/ports/1.json
  def destroy
    @port = @game.ports.find(params[:id])
    @port.destroy

    redirect_to game_ports_url(@game)
  end
end
