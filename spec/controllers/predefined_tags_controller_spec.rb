require 'spec_helper'

describe PredefinedTagsController do
  
  before do
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all predefined_tags as @predefined_tags" do
      predefined_tag = FactoryGirl.create(:predefined_tag)
      get_with @user, :index
      expect(assigns(:predefined_tags)).to eq([predefined_tag])
    end
  end

  describe "GET complete" do
    it "assigns all predefined_tags within a context as @predefined_tags" do
      # Fudge a fake context for this test
      PredefinedTag::CONTEXTS << ['Test', :tests]

      FactoryGirl.create(:predefined_tag)
      predefined_tags = FactoryGirl.create_list(:predefined_tag, 2, :context => "tests")
      get_with @user, :complete, { :context => 'tests' }
      expect(assigns(:predefined_tags)).to eq(predefined_tags)
    end
  end

  describe "GET show" do
    it "assigns the requested predefined_tag as @predefined_tag" do
      predefined_tag = FactoryGirl.create(:predefined_tag)
      get_with @user, :show, {:id => predefined_tag.to_param}
      expect(assigns(:predefined_tag)).to eq(predefined_tag)
    end
  end

  describe "GET new" do
    it "assigns a new predefined_tag as @predefined_tag" do
      get_with @user, :new, {}
      expect(assigns(:predefined_tag)).to be_a_new(PredefinedTag)
    end
  end

  describe "GET edit" do
    it "assigns the requested predefined_tag as @predefined_tag" do
      predefined_tag = FactoryGirl.create(:predefined_tag)
      get_with @user, :edit, {:id => predefined_tag.to_param}
      expect(assigns(:predefined_tag)).to eq(predefined_tag)
    end
  end

  describe "POST create" do
    before do
      @predefined_tag = FactoryGirl.attributes_for(:predefined_tag)
    end
    describe "with valid params" do
      it "creates a new PredefinedTag" do
        expect {
          post_with @user, :create, {:predefined_tag => @predefined_tag}
        }.to change(PredefinedTag, :count).by(1)
      end

      it "assigns a newly created predefined_tag as @predefined_tag" do
        post_with @user, :create, {:predefined_tag => @predefined_tag}
        expect(assigns(:predefined_tag)).to be_a(PredefinedTag)
        expect(assigns(:predefined_tag)).to be_persisted
      end

      it "redirects to the created predefined_tag" do
        post_with @user, :create, {:predefined_tag => @predefined_tag}
        expect(response).to redirect_to(PredefinedTag.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved predefined_tag as @predefined_tag" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PredefinedTag).to receive(:save).and_return(false)
        post_with @user, :create, {:predefined_tag => {}}
        expect(assigns(:predefined_tag)).to be_a_new(PredefinedTag)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PredefinedTag).to receive(:save).and_return(false)
        post_with @user, :create, {:predefined_tag => {}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested predefined_tag" do
        predefined_tag = FactoryGirl.create(:predefined_tag)
        # Assuming there are no other predefined_tags in the database, this
        # specifies that the PredefinedTag created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(PredefinedTag).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {:id => predefined_tag.to_param, :predefined_tag => {'these' => 'params'}}
      end

      it "assigns the requested predefined_tag as @predefined_tag" do
        predefined_tag = FactoryGirl.create(:predefined_tag)
        valid_attributes = FactoryGirl.attributes_for(:predefined_tag)
        put_with @user, :update, {:id => predefined_tag.to_param, :predefined_tag => valid_attributes}
        expect(assigns(:predefined_tag)).to eq(predefined_tag)
      end

      it "redirects to the predefined_tag" do
        predefined_tag = FactoryGirl.create(:predefined_tag)
        valid_attributes = FactoryGirl.attributes_for(:predefined_tag)
        put_with @user, :update, {:id => predefined_tag.to_param, :predefined_tag => valid_attributes}
        expect(response).to redirect_to(predefined_tag)
      end
    end

    describe "with invalid params" do
      it "assigns the predefined_tag as @predefined_tag" do
        predefined_tag = FactoryGirl.create(:predefined_tag)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PredefinedTag).to receive(:save).and_return(false)
        put_with @user, :update, {:id => predefined_tag.to_param, :predefined_tag => {}}
        expect(assigns(:predefined_tag)).to eq(predefined_tag)
      end

      it "re-renders the 'edit' template" do
        predefined_tag = FactoryGirl.create(:predefined_tag)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(PredefinedTag).to receive(:save).and_return(false)
        put_with @user, :update, {:id => predefined_tag.to_param, :predefined_tag => {}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested predefined_tag" do
      predefined_tag = FactoryGirl.create(:predefined_tag)
      expect {
        delete_with @user, :destroy, {:id => predefined_tag.to_param}
      }.to change(PredefinedTag, :count).by(-1)
    end

    it "redirects to the predefined_tags list" do
      predefined_tag = FactoryGirl.create(:predefined_tag)
      delete_with @user, :destroy, {:id => predefined_tag.to_param}
      expect(response).to redirect_to(predefined_tags_url)
    end
  end

end
