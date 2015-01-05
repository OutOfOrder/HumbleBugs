require "spec_helper"

describe CommentsController do
  describe "routing" do

    it "routes to #new" do
      expect(get("/issues/1/comments/new")).to route_to("comments#new", :issue_id => "1")
    end

    it "routes to #show" do
      expect(get("/issues/1/comments/1")).to route_to("comments#show", :issue_id => "1", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/issues/1/comments/1/edit")).to route_to("comments#edit", :issue_id => "1", :id => "1")
    end

    it "routes to #create" do
      expect(post("/issues/1/comments")).to route_to("comments#create", :issue_id => "1")
    end

    it "routes to #update" do
      expect(put("/issues/1/comments/1")).to route_to("comments#update", :issue_id => "1", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/issues/1/comments/1")).to route_to("comments#destroy", :issue_id => "1", :id => "1")
    end

  end
end
