require 'spec_helper'

describe IssuesController do

  before do
    @game = FactoryGirl.create(:game)
    @base_params = {:game_id => @game.to_param}
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all issues for the game as @issues" do
      FactoryGirl.create(:issue)
      issue = FactoryGirl.create(:issue, :game => @game)
      get_with @user, :index, @base_params
      assigns(:issues).should eq([issue])
    end
    it "with no game assigns all recent issues as @issues" do
      issue1 = FactoryGirl.create(:issue)
      issue = FactoryGirl.create(:issue, :game => @game)
      get_with @user, :index
      assigns(:issues).should =~ [issue, issue1]
    end
  end

  describe "GET show" do
    it "assigns the requested issue as @issue" do
      issue = FactoryGirl.create(:issue, :game => @game)
      get_with @user, :show, @base_params.merge({:id => issue.to_param})
      assigns(:issue).should eq(issue)
    end
  end

  describe "GET new" do
    it "assigns a new issue as @issue" do
      get_with @user, :new, @base_params
      assigns(:issue).should be_a_new(Issue)
    end
    context "with a shallow scope" do
      it "assigns a new issue as @issue" do
        get_with @user, :new
        assigns(:issue).tap do |t|
          t.should be_a_new(Issue)
          t.game.should be_nil
        end
      end
    end
    context 'as a regular user' do
      before do
        @regular_user = FactoryGirl.create :user, :roles => [:user]
        @game = FactoryGirl.create :game, :with_active_bundle
      end
      it 'should render when accessing the nested new' do
        get_with @regular_user, :new, {:game => @game.to_param}
        response.should render_template('new')
        response.should be_ok
      end
      it 'should render when accessing the shallow new' do
        get_with @regular_user, :new, {}
        response.should render_template('new')
        response.should be_ok
      end
      it 'should render the denied page when accessing the nested new with an invalid game' do
        game = FactoryGirl.create :game
        get_with @regular_user, :new, {game_id: game.to_param}
        response.should render_template('layouts/denied')
      end
    end
  end

  describe "GET edit" do
    it "assigns the requested issue as @issue" do
      issue = FactoryGirl.create(:issue, :game => @game)
      get_with @user, :edit, @base_params.merge({:id => issue.to_param})
      assigns(:issue).should eq(issue)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before do
        @issue = FactoryGirl.attributes_for(:issue, :new)
      end
      it '@issue attributes should not have game' do
        @issue[:game_id].should be_nil
      end
      it "creates a new Issue" do
        expect {
          post_with @user, :create, @base_params.merge({:issue => @issue})
        }.to change(Issue, :count).by(1)
      end

      it "assigns a newly created issue as @issue" do
        post_with @user, :create, @base_params.merge({:issue => @issue})
        assigns(:issue).should be_a(Issue)
        assigns(:issue).should be_persisted
      end

      it "redirects to the created issue" do
        post_with @user, :create, @base_params.merge({:issue => @issue})
        response.should redirect_to([@game, Issue.last])
      end

      context "with a shallow scope" do
        it "assigns a newly created issue as @issue" do
          post_with @user, :create, {:issue => @issue.merge({:game_id => @game.to_param})}
          assigns(:issue).tap do |t|
            t.should be_a(Issue)
            t.should be_persisted
          end
        end
      end

      it "should set the author to the logged in user" do
        post_with @user, :create, @base_params.merge({:issue => @issue})

        assigns(:issue).author.should == @user
      end

      it 'should not error when submitting an issue where no one is emailed' do
        expect {
          post_with @user, :create, @base_params.merge({:issue => @issue})
        }.to_not raise_error
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved issue as @issue" do
        # Trigger the behavior that occurs when invalid params are submitted
        Issue.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:issue => {}})
        assigns(:issue).should be_a_new(Issue)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Issue.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:issue => {}})
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested issue" do
        issue = FactoryGirl.create(:issue, :game => @game)
        # Assuming there are no other issues in the database, this
        # specifies that the Issue created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Issue.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, @base_params.merge({:id => issue.to_param, :issue => {'these' => 'params'}})
      end

      it "assigns the requested issue as @issue" do
        issue = FactoryGirl.create(:issue, :game => @game)
        put_with @user, :update, @base_params.merge({:id => issue.to_param, :issue => FactoryGirl.attributes_for(:issue)})
        assigns(:issue).should eq(issue)
      end

      it "redirects to the issue" do
        issue = FactoryGirl.create(:issue, :game => @game)
        put_with @user, :update, @base_params.merge({:id => issue.to_param, :issue => FactoryGirl.attributes_for(:issue)})
        response.should redirect_to([@game,issue])
      end
    end

    describe "with invalid params" do
      it "assigns the issue as @issue" do
        issue = FactoryGirl.create(:issue, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        Issue.any_instance.stub(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => issue.to_param, :issue => {}})
        assigns(:issue).should eq(issue)
      end

      it "re-renders the 'edit' template" do
        issue = FactoryGirl.create(:issue, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        Issue.any_instance.stub(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => issue.to_param, :issue => {}})
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested issue" do
      issue = FactoryGirl.create(:issue, :game => @game)
      expect {
        delete_with @user, :destroy, @base_params.merge({:id => issue.to_param})
      }.to change(Issue, :count).by(-1)
    end

    it "redirects to the issues list" do
      issue = FactoryGirl.create(:issue, :game => @game)
      delete_with @user, :destroy, @base_params.merge({:id => issue.to_param})
      response.should redirect_to(game_issues_url(@game))
    end
  end

end
