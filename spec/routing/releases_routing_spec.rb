require "spec_helper"

describe ReleasesController do
  describe "routing" do

    it "routes to #index" do
      get("/games/1/releases").should route_to("releases#index", :game_id => "1")
    end

    it "routes to #new" do
      get("/games/1/releases/new").should route_to("releases#new", :game_id => "1")
    end

    it "routes to #show" do
      get("/games/1/releases/1").should route_to("releases#show", :game_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/games/1/releases/1/edit").should route_to("releases#edit", :game_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/games/1/releases").should route_to("releases#create", :game_id => "1")
    end

    it "routes to #update" do
      put("/games/1/releases/1").should route_to("releases#update", :game_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/games/1/releases/1").should route_to("releases#destroy", :game_id => "1", :id => "1")
    end

  end
end
