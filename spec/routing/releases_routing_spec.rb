require "spec_helper"

describe ReleasesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/games/1/releases")).to route_to("releases#index", :game_id => "1")
    end

    it "routes to #new" do
      expect(get("/games/1/releases/new")).to route_to("releases#new", :game_id => "1")
    end

    it "routes to #download" do
      expect(get("/releases/1/download")).to route_to("releases#download", :id => "1")
    end

    it "routes to #show" do
      expect(get("/releases/1")).to route_to("releases#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/releases/1/edit")).to route_to("releases#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/games/1/releases")).to route_to("releases#create", :game_id => "1")
    end

    it "routes to #update" do
      expect(put("/releases/1")).to route_to("releases#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/releases/1")).to route_to("releases#destroy", :id => "1")
    end

  end
end
