class TestResultsController < ApplicationController
  filter_resource_access :nested_in => :releases, :shallow => true

  def index
    @test_results = @release.test_results.with_permissions_to
    respond_to do |format|
      format.html # show.js.erb
      format.js # index.js.erb
      format.json { render json: @test_results }
    end
  end

  # GET /test_results/1
  # GET /test_results/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @test_result }
    end
  end

  # GET /test_results/new
  # GET /test_results/new.json
  def new
  end

  # GET /test_results/1/edit
  def edit
  end

  # POST /test_results
  # POST /test_results.json
  def create
    respond_to do |format|
      if @test_result.save
        format.js { render action: "done", locals: { notice: 'Test result was successfully created.' }  }
        format.html { redirect_to game_url(@test_result.release.game, anchor: 'game_releases'), notice: 'Test result was successfully created.' }
        format.json { render json: @test_result, status: :created, location: @test_result }
      else
        format.js { render action: "error" }
        format.html { render action: "new" }
        format.json { render json: @test_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /test_results/1
  # PUT /test_results/1.json
  def update
    respond_to do |format|
      if @test_result.update_attributes(params[:test_result])
        format.js { render action: "done", locals: { notice: 'Test result was successfully updated.' } }
        format.html { redirect_to game_url(@test_result.release.game, anchor: 'game_releases'), notice: 'Test result was successfully updated.' }
        format.json { head :no_content }
      else
        format.js { render action: "error" }
        format.html { render action: "edit" }
        format.json { render json: @test_result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_results/1
  # DELETE /test_results/1.json
  def destroy
    @test_result.destroy

    respond_to do |format|
      format.js { render action: "done", locals: { notice: 'Test result was successfully deleted.' }  }
      format.html { redirect_to game_url(@test_result.release.game, anchor: 'game_releases') }
      format.json { head :no_content }
    end
  end

protected
  def new_test_result_from_params
    @test_result = @release.test_results.build params[:test_result]
    @test_result.user = current_user
  end

end
