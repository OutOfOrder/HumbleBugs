class IssuesController < ApplicationController
  filter_resource_access :nested_in => :games

  # GET /games/1/issues
  # GET /games/1/issues.json
  def index
    @issues = @game.issues.with_permissions_to

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /games/1/issues/1
  # GET /games/1/issues/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /games/1/issues/new
  # GET /games/1/issues/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /games/1/issues/1/edit
  def edit
  end

  # POST /games/1/issues
  # POST /games/1/issues.json
  def create
    respond_to do |format|
      if @issue.save
        format.html { redirect_to [@issue.game, @issue], notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: [@issue.game, @issue] }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1/issues/1
  # PUT /games/1/issues/1.json
  def update
    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        format.html { redirect_to [@game, @issue], notice: 'Issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1/issues/1
  # DELETE /games/1/issues/1.json
  def destroy
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to game_issues_url(@game) }
      format.json { head :no_content }
    end
  end

protected
  def load_game
    if params[:game_id]
      @game = Game.find(params[:game_id])
    else
      @game = nil
    end
  end

  def new_issue_from_params
    if @game.nil?
      @issue = Issue.new (params[:issue] || {}).merge(:author => current_user)
    else
      @issue = @game.issues.new (params[:issue] || {}).merge(:author => current_user)
    end
  end
end
