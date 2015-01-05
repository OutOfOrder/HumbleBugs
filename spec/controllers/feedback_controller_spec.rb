require 'spec_helper'

describe FeedbackController do
  before do
    @base_params = {format: :js}
    @user = FactoryGirl.create :user, roles: [:dev]
  end

  describe "GET 'new'" do
    it "assigns a new feedback as @feedback" do
      get_with @user, :new, @base_params
      expect(assigns(:feedback)).to be_a(Feedback)
    end
    it "returns http success" do
      get_with @user, :new, @base_params
      expect(response).to be_success
    end
    it 'should render the new template' do
      get_with @user, :new, @base_params
      expect(response).to render_template('new')
    end
  end

  describe "GET 'create'" do
    before do
      @feedback = FactoryGirl.attributes_for :feedback
    end
    describe "with valid params" do
      it "returns http success" do
        get_with @user, :create, @base_params.merge(feedback: @feedback)
        expect(response).to be_success
      end
      it "assigns a newly created comment as @comment" do
        post_with @user, :create, @base_params.merge({:feedback => @feedback})
        expect(assigns(:feedback)).to be_a(Feedback)
      end
      it "renders the create action" do
        post_with @user, :create, @base_params.merge(feedback: @feedback)
        expect(response).to render_template("create")
      end
      it "builds and delivers the feedback email" do
        mailer = double("FeedbackMailer")
        expect(mailer).to receive(:deliver)
        expect(FeedbackMailer).to receive(:submit_feedback).
            with(an_instance_of(User), an_instance_of(Feedback)).
            and_return(mailer)

        post_with @user, :create, @base_params.merge(feedback: @feedback)
      end
    end
    describe "with invalid params" do
      it 'should render the new template' do
        post_with @user, :create, @base_params.merge(feedback: {})
        expect(response).to render_template('new')
      end
    end
  end

end
