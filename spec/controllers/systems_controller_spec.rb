require 'spec_helper'

describe SystemsController do

  before do
    @user = FactoryGirl.create :user, roles: [:dev]
    @base_params = {user_id: @user.to_param}
  end

  describe "GET index" do
    it "assigns all systems as @systems" do
      system = FactoryGirl.create :system, user: @user
      get_with @user, :index, @base_params
      expect(assigns(:systems)).to eq([system])
    end
  end

  describe "GET show" do
    it "assigns the requested system as @system" do
      system = FactoryGirl.create :system, user: @user
      get_with @user, :show, @base_params.merge(id: system.to_param)
      expect(assigns(:system)).to eq(system)
    end
  end

  describe "GET new" do
    it "assigns a new system as @system" do
      get_with @user, :new, @base_params
      expect(assigns(:system)).to be_a_new(System)
    end
  end

  describe "GET edit" do
    it "assigns the requested system as @system" do
      system = FactoryGirl.create :system, user: @user
      get_with @user, :edit, @base_params.merge(id: system.to_param)
      expect(assigns(:system)).to eq(system)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new System" do
        expect {
          post_with @user, :create, @base_params.merge(system: FactoryGirl.attributes_for(:system))
        }.to change(System, :count).by(1)
      end

      it "assigns a newly created system as @system" do
        post_with @user, :create, @base_params.merge(system: FactoryGirl.attributes_for(:system))
        expect(assigns(:system)).to be_a(System)
        expect(assigns(:system)).to be_persisted
      end

      it "redirects to the user" do
        post_with @user, :create, @base_params.merge(system: FactoryGirl.attributes_for(:system))
        expect(response).to redirect_to(@user)
      end

      it "sets the user of the new System" do
        post_with @user, :create, @base_params.merge(system: FactoryGirl.attributes_for(:system))

        expect(assigns(:system).user).to eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved system as @system" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(System).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge(system: {})
        expect(assigns(:system)).to be_a_new(System)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(System).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge(system: {})
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested system" do
        system = FactoryGirl.create :system, user: @user
        # Assuming there are no other systems in the database, this
        # specifies that the System created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(System).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, @base_params.merge(id: system.to_param, system: {'these' => 'params'})
      end

      it "assigns the requested system as @system" do
        system = FactoryGirl.create :system, user: @user
        put_with @user, :update, @base_params.merge(id: system.to_param, system: FactoryGirl.attributes_for(:system))
        expect(assigns(:system)).to eq(system)
      end

      it "redirects to the user" do
        system = FactoryGirl.create :system, user: @user
        put_with @user, :update, @base_params.merge(id: system.to_param, system: FactoryGirl.attributes_for(:system))
        expect(response).to redirect_to(@user)
      end
    end

    describe "with invalid params" do
      it "assigns the system as @system" do
        system = FactoryGirl.create :system, user: @user
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(System).to receive(:save).and_return(false)
        put_with @user, :update, @base_params.merge(id: system.to_param, system: {})
        expect(assigns(:system)).to eq(system)
      end

      it "re-renders the 'edit' template" do
        system = FactoryGirl.create :system, user: @user
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(System).to receive(:save).and_return(false)
        put_with @user, :update, @base_params.merge(id: system.to_param, system: {})
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested system" do
      system = FactoryGirl.create :system, user: @user
      expect {
        delete_with @user, :destroy, @base_params.merge(id: system.to_param)
      }.to change(System, :count).by(-1)
    end

    it "redirects to the user" do
      system = FactoryGirl.create :system, user: @user
      delete_with @user, :destroy, @base_params.merge(id: system.to_param)
      expect(response).to redirect_to(@user)
    end
  end

end
