require "spec_helper"

describe GamesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/bundles/1/games")).to route_to("games#index", :bundle_id => "1")
    end

    it "routes to #new" do
      expect(get("/bundles/1/games/new")).to route_to("games#new", :bundle_id => "1")
    end

    it "routes to #show" do
      expect(get("/bundles/1/games/1")).to route_to("games#show", :bundle_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/bundles/1/games/1/edit")).to route_to("games#edit", :bundle_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(post("/bundles/1/games")).to route_to("games#create", :bundle_id => "1")
    end

    it "routes to #update" do
      expect(put("/bundles/1/games/1")).to route_to("games#update", :bundle_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/bundles/1/games/1")).to route_to("games#destroy", :bundle_id => "1", :id => "1")
    end

  end
end
