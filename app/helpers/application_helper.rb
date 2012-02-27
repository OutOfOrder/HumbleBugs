module ApplicationHelper
  def select_if options = {}
    if (controller_name == options[:controller].to_s)
      "selected"
    end
  end

  def label_for options, value
    options.rassoc(value.to_sym).first
  end
end
