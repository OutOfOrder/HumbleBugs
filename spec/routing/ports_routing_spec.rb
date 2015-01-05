require "spec_helper"

describe PortsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/games/1/ports")).to route_to("ports#index", :game_id => "1")
    end

    it "routes to #new" do
      expect(get("/games/1/ports/new")).to route_to("ports#new", :game_id => "1")
    end

    it "routes to #show" do
      expect(get("/games/1/ports/1")).to route_to("ports#show", :game_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/games/1/ports/1/edit")).to route_to("ports#edit", :game_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(post("/games/1/ports")).to route_to("ports#create", :game_id => "1")
    end

    it "routes to #update" do
      expect(put("/games/1/ports/1")).to route_to("ports#update", :game_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/games/1/ports/1")).to route_to("ports#destroy", :game_id => "1", :id => "1")
    end

  end
end
