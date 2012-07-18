require 'spec_helper'

describe ReleasesController do
  before do
    @game = FactoryGirl.create(:game)
    @base_params = { :game_id => @game.to_param }
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all releases as @releases" do
      FactoryGirl.create(:release)
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :index, @base_params
      assigns(:releases).should eq([release])
    end
  end

  describe "GET show" do
    it "assigns the requested release as @release" do
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :show, @base_params.merge({:id => release.to_param})
      assigns(:release).should eq(release)
    end
  end

  describe "GET new" do
    it "assigns a new release as @release" do
      get_with @user, :new, @base_params
      assigns(:release).should be_a_new(Release)
    end
  end

  describe "GET edit" do
    it "assigns the requested release as @release" do
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :edit, @base_params.merge({:id => release.to_param})
      assigns(:release).should eq(release)
    end
  end

  describe "POST create" do
    before do
      @release = FactoryGirl.build(:release, :game => nil).attributes.symbolize_keys.reject {|k,v| v.nil? }
    end
    describe "with valid params" do
      it "creates a new Release" do
        expect {
          post_with @user, :create, @base_params.merge({:release => @release})
        }.to change(Release, :count).by(1)
      end

      it "assigns a newly created release as @release" do
        post_with @user, :create, @base_params.merge({:release => @release})
        assigns(:release).should be_a(Release)
        assigns(:release).should be_persisted
      end

      it "redirects to the parent game" do
        post_with @user, :create, @base_params.merge({:release => @release})
        response.should redirect_to(@game)
      end

      it "should set the owner to the logged in user" do
        post_with @user, :create, @base_params.merge({:release => @release})

        assigns(:release).owner.should == @user
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved release as @release" do
        # Trigger the behavior that occurs when invalid params are submitted
        Release.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:release => {}})
        assigns(:release).should be_a_new(Release)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Release.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:release => {}})
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested release" do
        release = FactoryGirl.create(:release, :game => @game)
        # Assuming there are no other releases in the database, this
        # specifies that the Release created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Release.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, @base_params.merge({:id => release.to_param, :release => {'these' => 'params'}})
      end

      it "assigns the requested release as @release" do
        release = FactoryGirl.create(:release, :game => @game)
        put_with @user, :update, @base_params.merge({:id => release.to_param, :release => FactoryGirl.attributes_for(:release)})
        assigns(:release).should eq(release)
      end

      it "redirects to the parent game" do
        release = FactoryGirl.create(:release, :game => @game)
        put_with @user, :update, @base_params.merge({:id => release.to_param, :release => FactoryGirl.attributes_for(:release)})
        response.should redirect_to(@game)
      end
    end

    describe "with invalid params" do
      it "assigns the release as @release" do
        release = FactoryGirl.create(:release, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        Release.any_instance.stub(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => release.to_param, :release => {}})
        assigns(:release).should eq(release)
      end

      it "re-renders the 'edit' template" do
        release = FactoryGirl.create(:release, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        Release.any_instance.stub(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => release.to_param, :release => {}})
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested release" do
      release = FactoryGirl.create(:release, :game => @game)
      expect {
        delete_with @user, :destroy, @base_params.merge({:id => release.to_param})
      }.to change(Release, :count).by(-1)
    end

    it "redirects to the releases list" do
      release = FactoryGirl.create(:release, :game => @game)
      delete_with @user, :destroy, @base_params.merge({:id => release.to_param})
      response.should redirect_to(game_releases_url(@game))
    end
  end

end
