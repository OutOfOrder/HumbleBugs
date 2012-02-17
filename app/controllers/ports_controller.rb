class PortsController < ApplicationController
  # GET /ports
  # GET /ports.json
  def index
    @ports = Port.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ports }
    end
  end

  # GET /ports/1
  # GET /ports/1.json
  def show
    @port = Port.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @port }
    end
  end

  # GET /ports/new
  # GET /ports/new.json
  def new
    @port = Port.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @port }
    end
  end

  # GET /ports/1/edit
  def edit
    @port = Port.find(params[:id])
  end

  # POST /ports
  # POST /ports.json
  def create
    @port = Port.new(params[:port])

    respond_to do |format|
      if @port.save
        format.html { redirect_to @port, notice: 'Port was successfully created.' }
        format.json { render json: @port, status: :created, location: @port }
      else
        format.html { render action: "new" }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ports/1
  # PUT /ports/1.json
  def update
    @port = Port.find(params[:id])

    respond_to do |format|
      if @port.update_attributes(params[:port])
        format.html { redirect_to @port, notice: 'Port was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @port.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ports/1
  # DELETE /ports/1.json
  def destroy
    @port = Port.find(params[:id])
    @port.destroy

    respond_to do |format|
      format.html { redirect_to ports_url }
      format.json { head :no_content }
    end
  end
end
