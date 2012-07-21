require "spec_helper"

describe ReleasesController do
  describe "routing" do

    it "routes to #index" do
      get("/games/1/releases").should route_to("releases#index", :game_id => "1")
    end

    it "routes to #new" do
      get("/games/1/releases/new").should route_to("releases#new", :game_id => "1")
    end

    it "routes to #download" do
      get("/releases/1/download").should route_to("releases#download", :id => "1")
    end

    it "routes to #show" do
      get("/releases/1").should route_to("releases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/releases/1/edit").should route_to("releases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/games/1/releases").should route_to("releases#create", :game_id => "1")
    end

    it "routes to #update" do
      put("/releases/1").should route_to("releases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/releases/1").should route_to("releases#destroy", :id => "1")
    end

  end
end
