class PortsController < ApplicationController
  filter_resource_access :nested_in => :games

  # GET /games/1/ports
  # GET /games/1/ports.json
  def index
    @ports = @game.ports.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ports }
    end
  end

  # GET /games/1/ports/1
  # GET /games/1/ports/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @port }
    end
  end

  # GET /games/1/ports/new
  # GET /games/1/ports/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @port }
    end
  end

  # GET /games/1/ports/1/edit
  def edit
    @port = @game.ports.find(params[:id])
  end

  # POST /games/1/ports
  # POST /games/1/ports.json
  def create
    @port = @game.ports.new(params[:port])

    respond_to do |format|
      if @port.save
        format.html { redirect_to @game, notice: 'Port was successfully created.' }
        format.json { render json: @port, status: :created, location: @port }
      else
        format.html { render action: "new" }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1/ports/1
  # PUT /games/1/ports/1.json
  def update
    @port = @game.ports.find(params[:id])

    respond_to do |format|
      if @port.update_attributes(params[:port])
        format.html { redirect_to @game, notice: 'Port was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1/ports/1
  # DELETE /games/1/ports/1.json
  def destroy
    @port = @game.ports.find(params[:id])
    @port.destroy

    respond_to do |format|
      format.html { redirect_to game_ports_url(@game) }
      format.json { head :no_content }
    end
  end
end
