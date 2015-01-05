require 'spec_helper'

describe TestResultsController do
  before do
    @user = FactoryGirl.create :user, roles: [:dev]
  end

  describe "GET index" do
    it "assigns the requested test_results as @test_results" do
      release = FactoryGirl.create :release
      test_results = FactoryGirl.create_list :test_result, 2, release: release
      get_with @user, :index, {release_id: release.id}
      expect(assigns(:test_results)).to eq(test_results)
    end

  end

  describe "GET show" do
    it "assigns the requested test_result as @test_result" do
      test_result = FactoryGirl.create :test_result
      get_with @user, :show, {id: test_result.to_param}
      expect(assigns(:test_result)).to eq(test_result)
    end
  end

  describe "GET new" do
    it "assigns a new test_result as @test_result" do
      release = FactoryGirl.create :release
      get_with @user, :new, {release_id: release.id}
      expect(assigns(:test_result)).to be_a_new(TestResult)
    end
  end

  describe "GET edit" do
    it "assigns the requested test_result as @test_result" do
      test_result = FactoryGirl.create :test_result
      get_with @user, :edit, {id: test_result.to_param}
      expect(assigns(:test_result)).to eq(test_result)
    end
  end

  describe "POST create" do
    before do
      @release = FactoryGirl.create :release
      @base_params = {release_id: @release.to_param}
    end

    describe "with valid params" do
      before do
        @valid_attributes = FactoryGirl.attributes_for :test_result
        @valid_attributes[:system_id] = FactoryGirl.create(:system, user: @user).id
      end
      it "creates a new TestResult" do
        expect {
          post_with @user, :create, @base_params.merge(test_result: @valid_attributes)
        }.to change(TestResult, :count).by(1)
      end

      it "assigns a newly created test_result as @test_result" do
        post_with @user, :create, @base_params.merge(test_result: @valid_attributes)
        expect(assigns(:test_result)).to be_a(TestResult)
        expect(assigns(:test_result)).to be_persisted
      end

      it "redirects to the associated game" do
        post_with @user, :create, @base_params.merge(test_result: @valid_attributes)
        expect(response).to redirect_to(game_url(TestResult.last.release.game, anchor: "game_releases"))
      end
      it "should set the user to the logged in user" do
        post_with @user, :create, @base_params.merge({test_result: @valid_attributes})

        expect(assigns(:test_result).user).to eq(@user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved test_result as @test_result" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TestResult).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge(test_result: {})
        expect(assigns(:test_result)).to be_a_new(TestResult)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TestResult).to receive(:save).and_return(false)
        post_with @user, :create, @base_params.merge(test_result: {})
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      before do
        @valid_attributes = FactoryGirl.attributes_for :test_result
        @valid_attributes[:system_id] = FactoryGirl.create(:system, user: @user).id
      end
      it "updates the requested test_result" do
        test_result = FactoryGirl.create :test_result
        # Assuming there are no other test_results in the database, this
        # specifies that the TestResult created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        expect_any_instance_of(TestResult).to receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {id: test_result.to_param, test_result: {'these' => 'params'}}
      end

      it "assigns the requested test_result as @test_result" do
        test_result = FactoryGirl.create :test_result
        put_with @user, :update, {id: test_result.to_param, test_result: @valid_attributes}
        expect(assigns(:test_result)).to eq(test_result)
      end

      it "redirects to the associated game" do
        test_result = FactoryGirl.create :test_result
        put_with @user, :update, {id: test_result.to_param, test_result: @valid_attributes}
        expect(response).to redirect_to(game_url(test_result.release.game, anchor: "game_releases"))
      end
    end

    describe "with invalid params" do
      it "assigns the test_result as @test_result" do
        test_result = FactoryGirl.create :test_result
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TestResult).to receive(:save).and_return(false)
        put_with @user, :update, {id: test_result.to_param, test_result: {}}
        expect(assigns(:test_result)).to eq(test_result)
      end

      it "re-renders the 'edit' template" do
        test_result = FactoryGirl.create :test_result
        # Trigger the behavior that occurs when invalid params are submitted
        allow_any_instance_of(TestResult).to receive(:save).and_return(false)
        put_with @user, :update, {id: test_result.to_param, test_result: {}}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested test_result" do
      test_result = FactoryGirl.create :test_result
      expect {
        delete_with @user, :destroy, {id: test_result.to_param}
      }.to change(TestResult, :count).by(-1)
    end

    it "redirects to the associated game" do
      test_result = FactoryGirl.create :test_result
      delete_with @user, :destroy, {id: test_result.to_param}
      expect(response).to redirect_to(game_url(test_result.release.game, anchor: "game_releases"))
    end
  end

end
