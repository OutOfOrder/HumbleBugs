require "spec_helper"

describe BundlesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/bundles")).to route_to("bundles#index")
    end

    it "routes to #new" do
      expect(get("/bundles/new")).to route_to("bundles#new")
    end

    it "routes to #show" do
      expect(get("/bundles/1")).to route_to("bundles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/bundles/1/edit")).to route_to("bundles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/bundles")).to route_to("bundles#create")
    end

    it "routes to #update" do
      expect(put("/bundles/1")).to route_to("bundles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/bundles/1")).to route_to("bundles#destroy", :id => "1")
    end

  end
end
