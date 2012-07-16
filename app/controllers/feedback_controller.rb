class FeedbackController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.valid?
      FeedbackMailer.submit_feedback(current_user, @feedback).deliver
    else
      render :action => 'new'
    end
  end
end
