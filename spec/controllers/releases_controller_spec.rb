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
      expect(assigns(:releases)).to eq([release])
    end
  end

  describe "GET download" do
    it "assigns the requested release as @release" do
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :download, {:id => release.to_param}
      expect(assigns(:release)).to eq(release)
    end
    it "should redirect to the download url" do
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :download, {:id => release.to_param}
      expect(response).to redirect_to(release.url)
    end
    it "should increment the download count" do
      release = FactoryGirl.create(:release, :game => @game)
      expect {
        get_with @user, :download, {:id => release.to_param}
        release.reload
      }.to change(release, :download_count).by(1)
    end
  end

  describe "GET show" do
    it "assigns the requested release as @release" do
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :show, {:id => release.to_param}
      expect(assigns(:release)).to eq(release)
    end
  end

  describe "GET new" do
    it "assigns a new release as @release" do
      get_with @user, :new, @base_params
      expect(assigns(:release)).to be_a_new(Release)
    end
  end

  describe "GET edit" do
    it "assigns the requested release as @release" do
      release = FactoryGirl.create(:release, :game => @game)
      get_with @user, :edit, {:id => release.to_param}
      expect(assigns(:release)).to eq(release)
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
        expect(assigns(:release)).to be_a(Release)
        expect(assigns(:release)).to be_persisted
      end

      it "redirects to the parent game" do
        post_with @user, :create, @base_params.merge({:release => @release})
        expect(response).to redirect_to(game_url(@game, anchor:'game_releases'))
      end

      it "should set the owner to the logged in user" do
        post_with @user, :create, @base_params.merge({:release => @release})

        expect(assigns(:release).owner).to eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved release as @release" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Release).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:release => {}})
        expect(assigns(:release)).to be_a_new(Release)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Release).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:release => {}})
        expect(response).to render_template("new")
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
        expect_any_instance_of(Release).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {:id => release.to_param, :release => {'these' => 'params'}}
      end

      it "assigns the requested release as @release" do
        release = FactoryGirl.create(:release, :game => @game)
        put_with @user, :update, {:id => release.to_param, :release => FactoryGirl.attributes_for(:release)}
        expect(assigns(:release)).to eq(release)
      end

      it "redirects to the parent game" do
        release = FactoryGirl.create(:release, :game => @game)
        put_with @user, :update, @base_params.merge({:id => release.to_param, :release => FactoryGirl.attributes_for(:release)})
        expect(response).to redirect_to(game_url(@game, anchor:'game_releases'))
      end
    end

    describe "with invalid params" do
      it "assigns the release as @release" do
        release = FactoryGirl.create(:release, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Release).to receive(:save).and_return(false)
        put_with @user, :update, {:id => release.to_param, :release => {}}
        expect(assigns(:release)).to eq(release)
      end

      it "re-renders the 'edit' template" do
        release = FactoryGirl.create(:release, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Release).to receive(:save).and_return(false)
        put_with @user, :update, {:id => release.to_param, :release => {}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested release" do
      release = FactoryGirl.create(:release, :game => @game)
      expect {
        delete_with @user, :destroy, {:id => release.to_param}
      }.to change(Release, :count).by(-1)
    end

    it "redirects to the releases list" do
      release = FactoryGirl.create(:release, :game => @game)
      delete_with @user, :destroy, {:id => release.to_param}
      expect(response).to redirect_to(game_url(@game, anchor:'game_releases'))
    end
  end

end
