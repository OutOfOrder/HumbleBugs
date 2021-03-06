require 'spec_helper'

describe PortsController do
  before do
    @game = FactoryGirl.create(:game)
    @base_params = { :game_id => @game.to_param}
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all ports as @ports" do
      FactoryGirl.create(:port)
      port = FactoryGirl.create(:port, :game => @game)
      get_with @user, :index, @base_params
      expect(assigns(:ports)).to eq([port])
    end
  end

  describe "GET show" do
    it "assigns the requested port as @port" do
      port = FactoryGirl.create(:port, :game => @game)
      get_with @user, :show, @base_params.merge({:id => port.to_param})
      expect(assigns(:port)).to eq(port)
    end
  end

  describe "GET new" do
    it "assigns a new port as @port" do
      get_with @user, :new, @base_params
      expect(assigns(:port)).to be_a_new(Port)
    end
  end

  describe "GET edit" do
    it "assigns the requested port as @port" do
      port = FactoryGirl.create(:port, :game => @game)
      get_with @user, :edit, @base_params.merge({:id => port.to_param})
      expect(assigns(:port)).to eq(port)
    end
  end

  describe "POST create" do
    before do
      @port = FactoryGirl.build(:port, :game => nil).attributes.symbolize_keys.reject {|k,v| v.nil? }
    end
    describe "with valid params" do
      it "creates a new Port" do
        expect {
          post_with @user, :create, @base_params.merge({:port => @port})
        }.to change(Port, :count).by(1)
      end

      it "assigns a newly created port as @port" do
        post_with @user, :create, @base_params.merge({:port => @port})
        expect(assigns(:port)).to be_a(Port)
        expect(assigns(:port)).to be_persisted
      end

      it "redirects to the parent game" do
        post_with @user, :create, @base_params.merge({:port => @port})
        expect(response).to redirect_to(@game)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved port as @port" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Port).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:port => {}})
        expect(assigns(:port)).to be_a_new(Port)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Port).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:port => {}})
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested port" do
        port = FactoryGirl.create(:port, :game => @game)
        # Assuming there are no other ports in the database, this
        # specifies that the Port created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Port).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, @base_params.merge({:id => port.to_param, :port => {'these' => 'params'}})
      end

      it "assigns the requested port as @port" do
        port = FactoryGirl.create(:port, :game => @game)
        put_with @user, :update, @base_params.merge({:id => port.to_param, :port => FactoryGirl.attributes_for(:port, :game => @game)})
        expect(assigns(:port)).to eq(port)
      end

      it "redirects to the parent game" do
        port = FactoryGirl.create(:port, :game => @game)
        put_with @user, :update, @base_params.merge({:id => port.to_param, :port => FactoryGirl.attributes_for(:port, :game => @game)})
        expect(response).to redirect_to(@game)
      end
    end

    describe "with invalid params" do
      it "assigns the port as @port" do
        port = FactoryGirl.create(:port, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Port).to receive(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => port.to_param, :port => {}})
        expect(assigns(:port)).to eq(port)
      end

      it "re-renders the 'edit' template" do
        port = FactoryGirl.create(:port, :game => @game)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Port).to receive(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => port.to_param, :port => {}})
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested port" do
      port = FactoryGirl.create(:port, :game => @game)
      expect {
        delete_with @user, :destroy, @base_params.merge({:id => port.to_param})
      }.to change(Port, :count).by(-1)
    end

    it "redirects to the ports list" do
      port = FactoryGirl.create(:port, :game => @game)
      delete_with @user, :destroy, @base_params.merge({:id => port.to_param})
      expect(response).to redirect_to(game_ports_url(@game))
    end
  end

end
