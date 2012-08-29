module ApplicationHelper
  def select_if options = {}
    if (controller_name.to_sym == options[:controller])
      if options[:include].present?
        "selected" if options[:include].include?(action_name.to_sym)
      elsif options[:exclude].present?
        "selected" unless options[:exclude].include?(action_name.to_sym)
      else
        "selected"
      end
    end
  end

  def label_for options, value
    options.rassoc(value.to_sym).try(:first)
  end

  def platform_list platforms, separator = ", "
    platforms.map(&:name).join(separator)
  end

  def pretty_checksum checksum
    if checksum.nil?
      nil
    elsif checksum.length == 32 then
      "MD5: #{checksum}"
    elsif checksum.length == 40
      "SHA1: #{checksum}"
    end
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:time, l(time), options.merge(:datetime => time.getutc.iso8601)) if time
  end

  def multi_checkbox model, name, value, checked = false, options = {}
    html_options = {
      "type" => "checkbox",
      "name" => "#{model}[#{name}][]",
      "id" => sanitize_to_id("#{model}_#{name}_#{value}"),
      "value" => value,
    }.update(options.stringify_keys)
    html_options["checked"] = "checked" if checked
    tag :input, html_options
  end
end
