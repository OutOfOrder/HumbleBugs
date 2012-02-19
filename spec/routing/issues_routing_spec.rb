require "spec_helper"

describe IssuesController do
  describe "routing" do

    it "routes to #index" do
      get("/games/1/issues").should route_to("issues#index", :game_id => "1")
    end

    it "routes to #new" do
      get("/games/1/issues/new").should route_to("issues#new", :game_id => "1")
    end

    it "routes to #show" do
      get("/games/1/issues/1").should route_to("issues#show", :game_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/games/1/issues/1/edit").should route_to("issues#edit", :game_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/games/1/issues").should route_to("issues#create", :game_id => "1")
    end

    it "routes to #update" do
      put("/games/1/issues/1").should route_to("issues#update", :game_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/games/1/issues/1").should route_to("issues#destroy", :game_id => "1", :id => "1")
    end

  end
end
