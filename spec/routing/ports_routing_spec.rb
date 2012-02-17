require "spec_helper"

describe PortsController do
  describe "routing" do

    it "routes to #index" do
      get("/ports").should route_to("ports#index")
    end

    it "routes to #new" do
      get("/ports/new").should route_to("ports#new")
    end

    it "routes to #show" do
      get("/ports/1").should route_to("ports#show", :id => "1")
    end

    it "routes to #edit" do
      get("/ports/1/edit").should route_to("ports#edit", :id => "1")
    end

    it "routes to #create" do
      post("/ports").should route_to("ports#create")
    end

    it "routes to #update" do
      put("/ports/1").should route_to("ports#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/ports/1").should route_to("ports#destroy", :id => "1")
    end

  end
end
