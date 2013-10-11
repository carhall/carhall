module ApplicationHelper
  def active? name
    if "#{controller_path}##{action_name}".start_with? name
      " class=\"active\"".html_safe
    end
  end

  def translate_attribute_name attribute_name, scope
    I18n.translate("#{scope}.#{attribute_name}", scope: "activerecord.attributes")
  end
  
  def icon_link_to title, icon_class, path, options={}
    icon = content_tag(:i, nil, rel: :tooltip, title: title, class: icon_class)
    link_to icon, path, options
  end
end
