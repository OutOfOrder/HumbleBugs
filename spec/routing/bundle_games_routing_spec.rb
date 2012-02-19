require "spec_helper"

describe GamesController do
  describe "routing" do

    it "routes to #index" do
      get("/bundles/1/games").should route_to("games#index", :bundle_id => "1")
    end

    it "routes to #new" do
      get("/bundles/1/games/new").should route_to("games#new", :bundle_id => "1")
    end

    it "routes to #show" do
      get("/bundles/1/games/1").should route_to("games#show", :bundle_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/bundles/1/games/1/edit").should route_to("games#edit", :bundle_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/bundles/1/games").should route_to("games#create", :bundle_id => "1")
    end

    it "routes to #update" do
      put("/bundles/1/games/1").should route_to("games#update", :bundle_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bundles/1/games/1").should route_to("games#destroy", :bundle_id => "1", :id => "1")
    end

  end
end
