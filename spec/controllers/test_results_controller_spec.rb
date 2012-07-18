require 'spec_helper'

describe TestResultsController do
  before do
    @user = FactoryGirl.create :user, roles: [:dev]
  end

  describe "GET show" do
    it "assigns the requested test_result as @test_result" do
      test_result = FactoryGirl.create :test_result
      get_with @user, :show, {id: test_result.to_param}
      assigns(:test_result).should eq(test_result)
    end
  end

  describe "GET new" do
    it "assigns a new test_result as @test_result" do
      release = FactoryGirl.create :release
      get_with @user, :new, {release_id: release.id}
      assigns(:test_result).should be_a_new(TestResult)
    end
  end

  describe "GET edit" do
    it "assigns the requested test_result as @test_result" do
      test_result = FactoryGirl.create :test_result
      get_with @user, :edit, {id: test_result.to_param}
      assigns(:test_result).should eq(test_result)
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
          ap assigns(:test_result).errors.messages
        }.to change(TestResult, :count).by(1)
      end

      it "assigns a newly created test_result as @test_result" do
        post_with @user, :create, @base_params.merge(test_result: @valid_attributes)
        assigns(:test_result).should be_a(TestResult)
        assigns(:test_result).should be_persisted
      end

      it "redirects to the created test_result" do
        post_with @user, :create, @base_params.merge(test_result: @valid_attributes)
        response.should redirect_to(TestResult.last)
      end
      it "should set the user to the logged in user" do
        post_with @user, :create, @base_params.merge({test_result: @valid_attributes})

        assigns(:test_result).user.should == @user
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved test_result as @test_result" do
        # Trigger the behavior that occurs when invalid params are submitted
        TestResult.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge(test_result: {})
        assigns(:test_result).should be_a_new(TestResult)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        TestResult.any_instance.stub(:save).and_return(false)
        post_with @user, :create, @base_params.merge(test_result: {})
        response.should render_template("new")
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
        TestResult.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put_with @user, :update, {id: test_result.to_param, test_result: {'these' => 'params'}}
      end

      it "assigns the requested test_result as @test_result" do
        test_result = FactoryGirl.create :test_result
        put_with @user, :update, {id: test_result.to_param, test_result: @valid_attributes}
        assigns(:test_result).should eq(test_result)
      end

      it "redirects to the test_result" do
        test_result = FactoryGirl.create :test_result
        put_with @user, :update, {id: test_result.to_param, test_result: @valid_attributes}
        response.should redirect_to(test_result)
      end
    end

    describe "with invalid params" do
      it "assigns the test_result as @test_result" do
        test_result = FactoryGirl.create :test_result
        # Trigger the behavior that occurs when invalid params are submitted
        TestResult.any_instance.stub(:save).and_return(false)
        put_with @user, :update, {id: test_result.to_param, test_result: {}}
        assigns(:test_result).should eq(test_result)
      end

      it "re-renders the 'edit' template" do
        test_result = FactoryGirl.create :test_result
        # Trigger the behavior that occurs when invalid params are submitted
        TestResult.any_instance.stub(:save).and_return(false)
        put_with @user, :update, {id: test_result.to_param, test_result: {}}
        response.should render_template("edit")
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

    it "redirects to the test_results list" do
      test_result = FactoryGirl.create :test_result
      delete_with @user, :destroy, {id: test_result.to_param}
      response.should redirect_to(test_result.release.game)
    end
  end

end
