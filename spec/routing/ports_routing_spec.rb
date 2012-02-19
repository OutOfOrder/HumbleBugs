require "spec_helper"

describe PortsController do
  describe "routing" do

    it "routes to #index" do
      get("/games/1/ports").should route_to("ports#index", :game_id => "1")
    end

    it "routes to #new" do
      get("/games/1/ports/new").should route_to("ports#new", :game_id => "1")
    end

    it "routes to #show" do
      get("/games/1/ports/1").should route_to("ports#show", :game_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/games/1/ports/1/edit").should route_to("ports#edit", :game_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/games/1/ports").should route_to("ports#create", :game_id => "1")
    end

    it "routes to #update" do
      put("/games/1/ports/1").should route_to("ports#update", :game_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/games/1/ports/1").should route_to("ports#destroy", :game_id => "1", :id => "1")
    end

  end
end
