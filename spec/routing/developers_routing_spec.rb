require "spec_helper"

describe DevelopersController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/developers")).to route_to("developers#index")
    end

    it "routes to #new" do
      expect(get("/developers/new")).to route_to("developers#new")
    end

    it "routes to #show" do
      expect(get("/developers/1")).to route_to("developers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/developers/1/edit")).to route_to("developers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/developers")).to route_to("developers#create")
    end

    it "routes to #update" do
      expect(put("/developers/1")).to route_to("developers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/developers/1")).to route_to("developers#destroy", :id => "1")
    end

  end
end
