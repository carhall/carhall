module ApplicationHelper
  def active? *name
    options = name.extract_options!
    exists = name[1..-1]
    name = name.first
    return unless "#{controller_path}##{action_name}".start_with? name
    return if exists.detect { |k| params[k].blank? }
    return if options.detect { |k,v| params[k] != v }
    " class=\"active\"".html_safe
  end

  def translate_attribute_name attribute_name, scope
    I18n.translate("#{scope}.#{attribute_name}", scope: "activerecord.attributes")
  end
  
  def icon_link_to title, icon_class, path, options={}
    icon = content_tag(:i, nil, rel: :tooltip, title: title, class: icon_class)
    link_to icon, path, options
  end
end
