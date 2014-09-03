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

  def format_nil value
    value || '<span class="muted">无</span>'.html_safe
  end

  def from_title_get_map(title)
  	return "暂无地点，请直接联系" if title.blank?
  	title.match(/\((\d.*)\)/)
  	if $1
  	   lat,lng = $1.split(",")
  	   url="http://api.map.baidu.com/staticimage?width=400&height=200&markers=#{lat},#{lng}&zoom=14&markerStyles=s,A,0xff0000"	
  	   image_tag(url)
    end
    title
  #	http://api.map.baidu.com/staticimage?width=400&height=200&center=北京&markers=116.403874,39.914888&zoom=13&markerStyles=s,A,0xff0000
  end

end
