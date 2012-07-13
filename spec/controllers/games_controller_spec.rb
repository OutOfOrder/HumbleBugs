require 'spec_helper'

describe GamesController do

  before do
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all games as @games" do
      game = FactoryGirl.create(:game, bundle: nil)
      get_with @user, :index
      assigns(:games).should eq([game])
    end
    it "assigns all game in the bundle as @games" do
      games = FactoryGirl.create_list(:game, 2)
      get_with @user, :index, {:bundle_id => games.first.bundle.to_param}
      assigns(:bundle).should eq(games.first.bundle)
      assigns(:games).should eq([games.first])
    end
  end

  describe "GET show" do
    it "assigns the requested game as @game" do
      game = FactoryGirl.create(:game)
      get_with @user, :show, {:id => game.to_param}
      assigns(:game).should eq(game)
    end
    it "assigns the requested game as @game and bundle as @bundle" do
      game = FactoryGirl.create(:game)
      get_with @user, :show, {:bundle_id => game.bundle.to_param, :id => game.to_param}
      assigns(:bundle).should eq(game.bundle)
      assigns(:game).should eq(game)
    end
  end

  describe "GET new" do
    it "assigns a new game as @game" do
      bundle = FactoryGirl.create(:bundle)
      get_with @user, :new
      assigns(:game).should be_a_new(Game)
    end
  end

  describe "GET edit" do
    it "assigns the requested game as @game" do
      game = FactoryGirl.create(:game)
      get_with @user, :edit, {:id => game.to_param}
      assigns(:game).should eq(game)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Game" do
        expect {
          post_with @user, :create, {:game => FactoryGirl.attributes_for(:game)}
        }.to change(Game, :count).by(1)
      end

      it "assigns a newly created game as @game" do
        post_with @user, :create, {:game => FactoryGirl.attributes_for(:game)}
        assigns(:game).should be_a(Game)
        assigns(:game).should be_persisted
      end

      it "redirects to the created game" do
        post_with @user, :create, {:game => FactoryGirl.attributes_for(:game)}
        response.should redirect_to(Game.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved game as @game" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post_with @user, :create, {:game => {}}
        assigns(:game).should be_a_new(Game)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        post_with @user, :create, {:game => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested game" do
        game = FactoryGirl.create(:game)
        # Assuming there are no other games in the database, this
        # specifies that the Game created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Game.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {:id => game.to_param, :game => {'these' => 'params'}}
      end

      it "assigns the requested game as @game" do
        game = FactoryGirl.create(:game)
        put_with @user, :update, {:id => game.to_param, :game => FactoryGirl.attributes_for(:game)}
        assigns(:game).should eq(game)
      end

      it "redirects to the game" do
        game = FactoryGirl.create(:game)
        put_with @user, :update, {:id => game.to_param, :game => FactoryGirl.attributes_for(:game)}
        response.should redirect_to(game)
      end
    end

    describe "with invalid params" do
      it "assigns the game as @game" do
        game = FactoryGirl.create(:game)
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        put_with @user, :update, {:id => game.to_param, :game => {}}
        assigns(:game).should eq(game)
      end

      it "re-renders the 'edit' template" do
        game = FactoryGirl.create(:game)
        # Trigger the behavior that occurs when invalid params are submitted
        Game.any_instance.stub(:save).and_return(false)
        put_with @user, :update, {:id => game.to_param, :game => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested game" do
      game = FactoryGirl.create(:game)
      expect {
        delete_with @user, :destroy, {:id => game.to_param}
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      game = FactoryGirl.create(:game)
      delete_with @user, :destroy, {:id => game.to_param}
      response.should redirect_to(games_url)
    end
  end

end
