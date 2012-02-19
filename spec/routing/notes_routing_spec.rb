require "spec_helper"

describe NotesController do
  describe "routing" do

    it "routes to #index" do
      get("/issues/1/notes").should route_to("notes#index", :issue_id => "1")
    end

    it "routes to #new" do
      get("/issues/1/notes/new").should route_to("notes#new", :issue_id => "1")
    end

    it "routes to #show" do
      get("/issues/1/notes/1").should route_to("notes#show", :issue_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/issues/1/notes/1/edit").should route_to("notes#edit", :issue_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/issues/1/notes").should route_to("notes#create", :issue_id => "1")
    end

    it "routes to #update" do
      put("/issues/1/notes/1").should route_to("notes#update", :issue_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/issues/1/notes/1").should route_to("notes#destroy", :issue_id => "1", :id => "1")
    end

  end
end
