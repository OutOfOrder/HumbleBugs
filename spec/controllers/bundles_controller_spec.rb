require 'spec_helper'

describe BundlesController do

  before do
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all bundles as @bundles" do
      bundle = FactoryGirl.create(:bundle)
      get_with @user, :index
      expect(assigns(:bundles)).to eq([bundle])
    end
  end

  describe "GET show" do
    it "assigns the requested bundle as @bundle" do
      bundle = FactoryGirl.create(:bundle)
      get_with @user, :show, {:id => bundle.to_param}
      expect(assigns(:bundle)).to eq(bundle)
    end
  end

  describe "GET new" do
    it "assigns a new bundle as @bundle" do
      get_with @user, :new
      expect(assigns(:bundle)).to be_a_new(Bundle)
    end
  end

  describe "GET edit" do
    it "assigns the requested bundle as @bundle" do
      bundle = FactoryGirl.create(:bundle)
      get_with @user, :edit, {:id => bundle.to_param}
      expect(assigns(:bundle)).to eq(bundle)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Bundle" do
        expect {
          post_with @user, :create, {:bundle => FactoryGirl.attributes_for(:bundle)}
        }.to change(Bundle, :count).by(1)
      end

      it "assigns a newly created bundle as @bundle" do
        post_with @user, :create, {:bundle => FactoryGirl.attributes_for(:bundle)}
        expect(assigns(:bundle)).to be_a(Bundle)
        expect(assigns(:bundle)).to be_persisted
      end

      it "redirects to the created bundle" do
        post_with @user, :create, {:bundle => FactoryGirl.attributes_for(:bundle)}
        expect(response).to redirect_to(Bundle.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved bundle as @bundle" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Bundle).to receive(:save).and_return(false)
        post_with @user, :create, {:bundle => {}}
        expect(assigns(:bundle)).to be_a_new(Bundle)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Bundle).to receive(:save).and_return(false)
        post_with @user, :create, {:bundle => {}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested bundle" do
        bundle = FactoryGirl.create(:bundle)
        # Assuming there are no other bundles in the database, this
        # specifies that the Bundle created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Bundle).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {:id => bundle.to_param, :bundle => {'these' => 'params'}}
      end

      it "assigns the requested bundle as @bundle" do
        bundle = FactoryGirl.create(:bundle)
        put_with @user, :update, {:id => bundle.to_param, :bundle => FactoryGirl.attributes_for(:bundle)}
        expect(assigns(:bundle)).to eq(bundle)
      end

      it "redirects to the bundle" do
        bundle = FactoryGirl.create(:bundle)
        put_with @user, :update, {:id => bundle.to_param, :bundle => FactoryGirl.attributes_for(:bundle)}
        expect(response).to redirect_to(bundle)
      end
    end

    describe "with invalid params" do
      it "assigns the bundle as @bundle" do
        bundle = FactoryGirl.create(:bundle)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Bundle).to receive(:save).and_return(false)
        put_with @user, :update, {:id => bundle.to_param, :bundle => {}}
        expect(assigns(:bundle)).to eq(bundle)
      end

      it "re-renders the 'edit' template" do
        bundle = FactoryGirl.create(:bundle)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Bundle).to receive(:save).and_return(false)
        put_with @user, :update, {:id => bundle.to_param, :bundle => {}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested bundle" do
      bundle = FactoryGirl.create(:bundle)
      expect {
        delete_with @user, :destroy, {:id => bundle.to_param}
      }.to change(Bundle, :count).by(-1)
    end

    it "redirects to the bundles list" do
      bundle = FactoryGirl.create(:bundle)
      delete_with @user, :destroy, {:id => bundle.to_param}
      expect(response).to redirect_to(bundles_url)
    end
  end

end
