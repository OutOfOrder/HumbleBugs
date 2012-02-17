require "spec_helper"

describe ReleasesController do
  describe "routing" do

    it "routes to #index" do
      get("/releases").should route_to("releases#index")
    end

    it "routes to #new" do
      get("/releases/new").should route_to("releases#new")
    end

    it "routes to #show" do
      get("/releases/1").should route_to("releases#show", :id => "1")
    end

    it "routes to #edit" do
      get("/releases/1/edit").should route_to("releases#edit", :id => "1")
    end

    it "routes to #create" do
      post("/releases").should route_to("releases#create")
    end

    it "routes to #update" do
      put("/releases/1").should route_to("releases#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/releases/1").should route_to("releases#destroy", :id => "1")
    end

  end
end
