require "spec_helper"

describe PredefinedTagsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/predefined_tags")).to route_to("predefined_tags#index")
    end

    it "routes to #new" do
      expect(get("/predefined_tags/new")).to route_to("predefined_tags#new")
    end

    describe 'routes to #complete should match a word' do
      it "without new in it" do
        expect(get("/predefined_tags/platforms")).to route_to("predefined_tags#complete", :context => 'platforms')
      end

      it "that begins with new" do
        expect(get("/predefined_tags/newness")).to route_to("predefined_tags#complete", :context => 'newness')
      end

      it "that contains new" do
        expect(get("/predefined_tags/platnew")).to route_to("predefined_tags#complete", :context => 'platnew')
      end

      it "that ends with new" do
        expect(get("/predefined_tags/platnewplat")).to route_to("predefined_tags#complete", :context => 'platnewplat')
      end
    end

    it "routes to #show" do
      expect(get("/predefined_tags/1")).to route_to("predefined_tags#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/predefined_tags/1/edit")).to route_to("predefined_tags#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/predefined_tags")).to route_to("predefined_tags#create")
    end

    it "routes to #update" do
      expect(put("/predefined_tags/1")).to route_to("predefined_tags#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/predefined_tags/1")).to route_to("predefined_tags#destroy", :id => "1")
    end

  end
end
