require "spec_helper"

describe PredefinedTagsController do
  describe "routing" do

    it "routes to #index" do
      get("/predefined_tags").should route_to("predefined_tags#index")
    end

    it "routes to #new" do
      get("/predefined_tags/new").should route_to("predefined_tags#new")
    end

    it "routes to #show" do
      get("/predefined_tags/1").should route_to("predefined_tags#show", :id => "1")
    end

    it "routes to #edit" do
      get("/predefined_tags/1/edit").should route_to("predefined_tags#edit", :id => "1")
    end

    it "routes to #create" do
      post("/predefined_tags").should route_to("predefined_tags#create")
    end

    it "routes to #update" do
      put("/predefined_tags/1").should route_to("predefined_tags#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/predefined_tags/1").should route_to("predefined_tags#destroy", :id => "1")
    end

  end
end
