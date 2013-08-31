module ApplicationHelper
  def active? name
    if controller_name == name
      " class=\"active\"".html_safe
    end
  end

  def translate_attribute_name attribute_name, scope
    I18n.translate("#{scope}.#{attribute_name}", scope: "activerecord.attributes")
  end
end
