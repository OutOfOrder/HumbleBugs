require 'spec_helper'

describe UsersController do

  before do
    @user = FactoryGirl.create :user, :roles => [:dev]
  end

  describe "GET index" do
    it "assigns all users as @users" do
      user = FactoryGirl.create(:user)
      users = User.all
      get_with @user, :index
      expect(assigns(:users)).to eq(users)
    end
  end

  describe "GET show" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:user)
      get_with @user, :show, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      get_with @user, :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "GET edit" do
    it "assigns the requested user as @user" do
      user = FactoryGirl.create(:user)
      get_with @user, :edit, {:id => user.to_param}
      expect(assigns(:user)).to eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post_with @user, :create, {:user => FactoryGirl.attributes_for(:user)}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post_with @user, :create, {:user => FactoryGirl.attributes_for(:user)}
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it "redirects to the login screen" do
        post_with @user, :create, {:user => FactoryGirl.attributes_for(:user)}
        expect(response).to redirect_to(login_url)
      end

      it "should call send_confirm_account on the matched user" do
        expect_any_instance_of(User).to receive(:send_confirm_account)
        post_with @user, :create, {:user => FactoryGirl.attributes_for(:user)}
      end

      it "builds and sends the confirm_account email" do
        mailer = double("UserMailer")
        expect(mailer).to receive(:deliver)
        expect(UserMailer).to receive(:confirm_account).
            with(an_instance_of(User)).
            and_return(mailer)

        post_with @user, :create, {:user => FactoryGirl.attributes_for(:user)}
      end

      it "builds and sends the new_account email" do
        mailer = double("UserMailer")
        expect(mailer).to receive(:deliver)
        expect(UserMailer).to receive(:new_account).
            with(an_instance_of(User)).
            and_return(mailer)

        post_with @user, :create, {:user => FactoryGirl.attributes_for(:user)}
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post_with @user, :create, {:user => {}}
        expect(assigns(:user)).to be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to receive(:save).and_return(false)
        post_with @user, :create, {:user => {}}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        user = FactoryGirl.create(:user)
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(User).to receive(:update_attributes).with({'these' => 'params'}, {:as => :manager})
        put_with @user, :update, {:id => user.to_param, :user => {'these' => 'params'}}
      end

      it "assigns the requested user as @user" do
        user = FactoryGirl.create(:user)
        put_with @user, :update, {:id => user.to_param, :user => FactoryGirl.attributes_for(:user)}
        expect(assigns(:user)).to eq(user)
      end

      it "redirects to the user" do
        user = FactoryGirl.create(:user)
        put_with @user, :update, {:id => user.to_param, :user => FactoryGirl.attributes_for(:user)}
        expect(response).to redirect_to(user)
      end
    end

    describe "with invalid params" do
      it "assigns the user as @user" do
        user = FactoryGirl.create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put_with @user, :update, {:id => user.to_param, :user => {}}
        expect(assigns(:user)).to eq(user)
      end

      it "re-renders the 'edit' template" do
        user = FactoryGirl.create(:user)
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(User).to receive(:save).and_return(false)
        put_with @user, :update, {:id => user.to_param, :user => {}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested user" do
      user = FactoryGirl.create(:user)
      expect {
        delete_with @user, :destroy, {:id => user.to_param}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = FactoryGirl.create(:user)
      delete_with @user, :destroy, {:id => user.to_param}
      expect(response).to redirect_to(users_url)
    end
  end

end
