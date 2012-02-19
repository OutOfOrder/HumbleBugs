class IssuesController < ApplicationController

  before_filter :load_game

  # GET /games/1/issues
  # GET /games/1/issues.json
  def index
    @issues = @game.issues

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @issues }
    end
  end

  # GET /games/1/issues/1
  # GET /games/1/issues/1.json
  def show
    @issue = @game.issues.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /games/1/issues/new
  # GET /games/1/issues/new.json
  def new
    @issue = @game.issues.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @issue }
    end
  end

  # GET /games/1/issues/1/edit
  def edit
    @issue = @game.issues.find(params[:id])
  end

  # POST /games/1/issues
  # POST /games/1/issues.json
  def create
    @issue = @game.issues.build(params[:issue])

    respond_to do |format|
      if @issue.save
        format.html { redirect_to [@game, @issue], notice: 'Issue was successfully created.' }
        format.json { render json: @issue, status: :created, location: [@game,@issue] }
      else
        format.html { render action: "new" }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1/issues/1
  # PUT /games/1/issues/1.json
  def update
    @issue = @game.issues.find(params[:id])

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
    @issue = Issue.find(params[:id])
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to game_issues_url(@game) }
      format.json { head :no_content }
    end
  end

private
  def load_game
    @game = Game.find(params[:game_id])
  end
end
