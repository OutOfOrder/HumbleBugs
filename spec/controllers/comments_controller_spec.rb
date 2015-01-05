require 'spec_helper'

describe CommentsController do
  
  before do
    # probably should be a MOCK
    @commentable = FactoryGirl.create(:issue)
    @base_params = {:issue_id => @commentable.to_param, :format => :js}
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET show" do
    it "assigns the requested comment as @comment" do
      comment = FactoryGirl.create(:comment, :commentable => @commentable)
      get_with @user, :show, @base_params.merge({:id => comment.to_param})
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "GET new" do
    it "assigns a new comment as @comment" do
      get_with @user, :new, @base_params
      expect(assigns(:comment)).to be_a_new(Comment)
    end
  end

  describe "GET edit" do
    it "assigns the requested comment as @comment" do
      comment = FactoryGirl.create(:comment, :commentable => @commentable)
      get_with @user, :edit, @base_params.merge({:id => comment.to_param})
      expect(assigns(:comment)).to eq(comment)
    end
  end

  describe "POST create" do
    before do
      @comment = FactoryGirl.attributes_for :comment
    end
    describe "with valid params" do
      it "creates a new Comment" do
        expect {
          post_with @user, :create, @base_params.merge({:comment => @comment})
        }.to change(Comment, :count).by(1)
      end

      it "assigns a newly created comment as @comment" do
        post_with @user, :create, @base_params.merge({:comment => @comment})
        expect(assigns(:comment)).to be_a(Comment)
        expect(assigns(:comment)).to be_persisted
      end

      it "renders the create action" do
        post_with @user, :create, @base_params.merge({:comment => @comment})
        expect(response).to render_template("create")
      end

      it "should set the author to the logged in user" do
        post_with @user, :create, @base_params.merge({:comment => @comment})

        expect(assigns(:comment).author).to eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved comment as @comment" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:comment => {}})
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:comment => {}})
        expect(response).to render_template("comments/error")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested comment" do
        comment = FactoryGirl.create(:comment, :commentable => @commentable)
        # Assuming there are no other comments in the database, this
        # specifies that the Comment created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(Comment).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, @base_params.merge({:id => comment.to_param, :comment => {'these' => 'params'}})
      end

      it "assigns the requested comment as @comment" do
        comment = FactoryGirl.create(:comment, :commentable => @commentable)
        put_with @user, :update, @base_params.merge({:id => comment.to_param, :comment => FactoryGirl.attributes_for(:comment)})
        expect(assigns(:comment)).to eq(comment)
      end

      it "renders the show template" do
        comment = FactoryGirl.create(:comment, :commentable => @commentable)
        put_with @user, :update, @base_params.merge({:id => comment.to_param, :comment => FactoryGirl.attributes_for(:comment)})
        expect(response).to render_template("show")
      end
    end

    describe "with invalid params" do
      it "assigns the comment as @comment" do
        comment = FactoryGirl.create(:comment, :commentable => @commentable)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => comment.to_param, :comment => {}})
        expect(assigns(:comment)).to eq(comment)
      end

      it "re-renders the 'edit' template" do
        comment = FactoryGirl.create(:comment, :commentable => @commentable)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(Comment).to receive(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => comment.to_param, :comment => {}})
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested comment" do
      comment = FactoryGirl.create(:comment, :commentable => @commentable)
      expect {
        delete_with @user, :destroy, @base_params.merge({:id => comment.to_param})
      }.to change(Comment, :count).by(-1)
    end

    it "renders the destoy action" do
      comment = FactoryGirl.create(:comment, :commentable => @commentable)
      delete_with @user, :destroy, @base_params.merge({:id => comment.to_param})
      expect(response).to render_template("destroy")
    end
  end

end
