require "spec_helper"

describe IssuesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/games/1/issues")).to route_to("issues#index", :game_id => "1")
    end

    it "routes to #new" do
      expect(get("/games/1/issues/new")).to route_to("issues#new", :game_id => "1")
    end

    it "routes to #show" do
      expect(get("/games/1/issues/1")).to route_to("issues#show", :game_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/games/1/issues/1/edit")).to route_to("issues#edit", :game_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(post("/games/1/issues")).to route_to("issues#create", :game_id => "1")
    end

    it "routes to #update" do
      expect(put("/games/1/issues/1")).to route_to("issues#update", :game_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/games/1/issues/1")).to route_to("issues#destroy", :game_id => "1", :id => "1")
    end

  end
end
