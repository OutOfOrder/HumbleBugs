require "spec_helper"

describe SystemsController do
  describe "routing" do

    it "routes to #index" do
      get("/users/1/systems").should route_to("systems#index", :user_id => "1")
    end

    it "routes to #new" do
      get("/users/1/systems/new").should route_to("systems#new", :user_id => "1")
    end

    it "routes to #show" do
      get("/users/1/systems/1").should route_to("systems#show", :user_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/users/1/systems/1/edit").should route_to("systems#edit", :user_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/users/1/systems").should route_to("systems#create", :user_id => "1")
    end

    it "routes to #update" do
      put("/users/1/systems/1").should route_to("systems#update", :user_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/users/1/systems/1").should route_to("systems#destroy", :user_id => "1", :id => "1")
    end

  end
end
