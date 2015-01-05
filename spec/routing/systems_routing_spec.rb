require "spec_helper"

describe SystemsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/users/1/systems")).to route_to("systems#index", :user_id => "1")
    end

    it "routes to #new" do
      expect(get("/users/1/systems/new")).to route_to("systems#new", :user_id => "1")
    end

    it "routes to #show" do
      expect(get("/users/1/systems/1")).to route_to("systems#show", :user_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/users/1/systems/1/edit")).to route_to("systems#edit", :user_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(post("/users/1/systems")).to route_to("systems#create", :user_id => "1")
    end

    it "routes to #update" do
      expect(put("/users/1/systems/1")).to route_to("systems#update", :user_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/users/1/systems/1")).to route_to("systems#destroy", :user_id => "1", :id => "1")
    end

  end
end
