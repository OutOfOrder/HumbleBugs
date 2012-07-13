require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #new" do
      get("/issues/1/comments/new").should route_to("comments#new", :issue_id => "1")
    end

    it "routes to #show" do
      get("/issues/1/comments/1").should route_to("comments#show", :issue_id => "1", :id => "1")
    end

    it "routes to #edit" do
      get("/issues/1/comments/1/edit").should route_to("comments#edit", :issue_id => "1", :id => "1")
    end

    it "routes to #create" do
      post("/issues/1/comments").should route_to("comments#create", :issue_id => "1")
    end

    it "routes to #update" do
      put("/issues/1/comments/1").should route_to("comments#update", :issue_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      delete("/issues/1/comments/1").should route_to("comments#destroy", :issue_id => "1", :id => "1")
    end

  end
end
