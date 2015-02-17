class BundlesController < ApplicationController
  filter_resource_access

  # GET /bundles
  # GET /bundles.json
  def index
    @bundles = Bundle.with_permissions_to.order('bundles.target_date DESC')
  end

  # GET /bundles/1
  # GET /bundles/1.json
  def show
  end

  # GET /bundles/new
  # GET /bundles/new.json
  def new
  end

  # GET /bundles/1/edit
  def edit
  end

  # POST /bundles
  # POST /bundles.json
  def create
    if @bundle.save
      redirect_to @bundle, notice: 'Bundle was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /bundles/1
  # PUT /bundles/1.json
  def update
    if @bundle.update_attributes(params[:bundle])
      redirect_to @bundle, notice: 'Bundle was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /bundles/1
  # DELETE /bundles/1.json
  def destroy
    @bundle.destroy

    redirect_to bundles_url
  end
end
