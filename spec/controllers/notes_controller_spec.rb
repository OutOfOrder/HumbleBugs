require 'spec_helper'

describe NotesController do
  
  before do
    # probably should be a MOCK
    @noteable = FactoryGirl.create(:issue)
    @base_params = {:issue_id => @noteable.to_param}
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all notes as @notes" do
      FactoryGirl.create(:note)
      note = FactoryGirl.create(:note, :noteable => @noteable)
      get_with @user, :index, @base_params
      assigns(:notes).should eq([note])
    end
  end

  describe "GET show" do
    it "assigns the requested note as @note" do
      note = FactoryGirl.create(:note, :noteable => @noteable)
      get_with @user, :show, @base_params.merge({:id => note.to_param})
      assigns(:note).should eq(note)
    end
  end

  describe "GET new" do
    it "assigns a new note as @note" do
      get_with @user, :new, @base_params
      assigns(:note).should be_a_new(Note)
    end
  end

  describe "GET edit" do
    it "assigns the requested note as @note" do
      note = FactoryGirl.create(:note, :noteable => @noteable)
      get_with @user, :edit, @base_params.merge({:id => note.to_param})
      assigns(:note).should eq(note)
    end
  end

  describe "POST create" do
    before do
      @note = FactoryGirl.build(:note, :noteable => @noteable).attributes.symbolize_keys.reject {|k,v| v.nil? }
    end
    describe "with valid params" do
      it "creates a new Note" do
        expect {
          post_with @user, :create, @base_params.merge({:note => @note})
        }.to change(Note, :count).by(1)
      end

      it "assigns a newly created note as @note" do
        post_with @user, :create, @base_params.merge({:note => @note})
        assigns(:note).should be_a(Note)
        assigns(:note).should be_persisted
      end

      it "redirects to the created note" do
        post_with @user, :create, @base_params.merge({:note => @note})
        response.should redirect_to([@noteable, Note.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved note as @note" do
        # Trigger the behavior that occurs when invalid params are submitted
        Note.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:note => {}})
        assigns(:note).should be_a_new(Note)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Note.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge({:note => {}})
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested note" do
        note = FactoryGirl.create(:note, :noteable => @noteable)
        # Assuming there are no other notes in the database, this
        # specifies that the Note created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Note.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, @base_params.merge({:id => note.to_param, :note => {'these' => 'params'}})
      end

      it "assigns the requested note as @note" do
        note = FactoryGirl.create(:note, :noteable => @noteable)
        put_with @user, :update, @base_params.merge({:id => note.to_param, :note => FactoryGirl.attributes_for(:note)})
        assigns(:note).should eq(note)
      end

      it "redirects to the note" do
        note = FactoryGirl.create(:note, :noteable => @noteable)
        put_with @user, :update, @base_params.merge({:id => note.to_param, :note => FactoryGirl.attributes_for(:note)})
        response.should redirect_to([@noteable, note])
      end
    end

    describe "with invalid params" do
      it "assigns the note as @note" do
        note = FactoryGirl.create(:note, :noteable => @noteable)
        # Trigger the behavior that occurs when invalid params are submitted
        Note.any_instance.stub(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => note.to_param, :note => {}})
        assigns(:note).should eq(note)
      end

      it "re-renders the 'edit' template" do
        note = FactoryGirl.create(:note, :noteable => @noteable)
        # Trigger the behavior that occurs when invalid params are submitted
        Note.any_instance.stub(:save).and_return(false)
        put_with @user, :update, @base_params.merge({:id => note.to_param, :note => {}})
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested note" do
      note = FactoryGirl.create(:note, :noteable => @noteable)
      expect {
        delete_with @user, :destroy, @base_params.merge({:id => note.to_param})
      }.to change(Note, :count).by(-1)
    end

    it "redirects to the notes list" do
      note = FactoryGirl.create(:note, :noteable => @noteable)
      delete_with @user, :destroy, @base_params.merge({:id => note.to_param})
      response.should redirect_to([@noteable, Note])
    end
  end

end
