require "spec_helper"

describe BundlesController do
  describe "routing" do

    it "routes to #index" do
      get("/bundles").should route_to("bundles#index")
    end

    it "routes to #new" do
      get("/bundles/new").should route_to("bundles#new")
    end

    it "routes to #show" do
      get("/bundles/1").should route_to("bundles#show", :id => "1")
    end

    it "routes to #edit" do
      get("/bundles/1/edit").should route_to("bundles#edit", :id => "1")
    end

    it "routes to #create" do
      post("/bundles").should route_to("bundles#create")
    end

    it "routes to #update" do
      put("/bundles/1").should route_to("bundles#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/bundles/1").should route_to("bundles#destroy", :id => "1")
    end

  end
end
