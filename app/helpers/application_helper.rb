module ApplicationHelper
  def select_if options = {}
    if (controller_name == options[:controller].to_s)
      "selected"
    end
  end
end
