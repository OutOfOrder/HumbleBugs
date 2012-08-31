require 'spec_helper'

describe DevelopersController do
  before do
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all developers as @developers" do
      developer = FactoryGirl.create(:developer)
      get_with @user, :index, {}
      assigns(:developers).should eq([developer])
    end
  end

  describe "GET show" do
    it "assigns the requested developer as @developer" do
      developer = FactoryGirl.create(:developer)
      get_with @user, :show, {:id => developer.to_param}
      assigns(:developer).should eq(developer)
    end
  end

  describe "GET new" do
    it "assigns a new developer as @developer" do
      get_with @user, :new, {}
      assigns(:developer).should be_a_new(Developer)
    end
  end

  describe "GET edit" do
    it "assigns the requested developer as @developer" do
      developer = FactoryGirl.create(:developer)
      get_with @user, :edit, {:id => developer.to_param}
      assigns(:developer).should eq(developer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Developer" do
        expect {
          post_with @user, :create, {:developer => FactoryGirl.attributes_for(:developer)}
        }.to change(Developer, :count).by(1)
      end

      it "assigns a newly created developer as @developer" do
        post_with @user, :create, {:developer => FactoryGirl.attributes_for(:developer)}
        assigns(:developer).should be_a(Developer)
        assigns(:developer).should be_persisted
      end

      it "redirects to the created developer" do
        post_with @user, :create, {:developer => FactoryGirl.attributes_for(:developer)}
        response.should redirect_to(Developer.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved developer as @developer" do
        # Trigger the behavior that occurs when invalid params are submitted
        Developer.any_instance.stub(:save).and_return(false)
        post_with @user, :create, {:developer => {}}
        assigns(:developer).should be_a_new(Developer)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Developer.any_instance.stub(:save).and_return(false)
        post_with @user, :create, {:developer => {}}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested developer" do
        developer = FactoryGirl.create(:developer)
        # Assuming there are no other developers in the database, this
        # specifies that the Developer created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Developer.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {:id => developer.to_param, :developer => {'these' => 'params'}}
      end

      it "assigns the requested developer as @developer" do
        developer = FactoryGirl.create(:developer)
        put_with @user, :update, {:id => developer.to_param, :developer => FactoryGirl.attributes_for(:developer)}
        assigns(:developer).should eq(developer)
      end

      it "redirects to the developer" do
        developer = FactoryGirl.create(:developer)
        put_with @user, :update, {:id => developer.to_param, :developer => FactoryGirl.attributes_for(:developer)}
        response.should redirect_to(developer)
      end
    end

    describe "with invalid params" do
      it "assigns the developer as @developer" do
        developer = FactoryGirl.create(:developer)
        # Trigger the behavior that occurs when invalid params are submitted
        Developer.any_instance.stub(:save).and_return(false)
        put_with @user, :update, {:id => developer.to_param, :developer => {}}
        assigns(:developer).should eq(developer)
      end

      it "re-renders the 'edit' template" do
        developer = FactoryGirl.create(:developer)
        # Trigger the behavior that occurs when invalid params are submitted
        Developer.any_instance.stub(:save).and_return(false)
        put_with @user, :update, {:id => developer.to_param, :developer => {}}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested developer" do
      developer = FactoryGirl.create(:developer)
      expect {
        delete_with @user, :destroy, {:id => developer.to_param}
      }.to change(Developer, :count).by(-1)
    end

    it "redirects to the developers list" do
      developer = FactoryGirl.create(:developer)
      delete_with @user, :destroy, {:id => developer.to_param}
      response.should redirect_to(developers_url)
    end
  end

end
