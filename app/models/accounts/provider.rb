class Accounts::Provider < Accounts::PublicAccount
  set_detail_class Accounts::ProviderDetail
  
  has_many :hosts, class_name: 'Bcst::Host'
  has_many :programmes, class_name: 'Bcst::Programme'
  has_many :programme_lists, class_name: 'Bcst::ProgrammeList'

  has_many :exposures, class_name: 'Bcst::Exposure'
  has_many :traffic_reports, class_name: 'Bcst::TrafficReport'

  def has_template? template
    return true unless Accounts::ProviderDetail::TemplateSymbols.include? template
    return detail.template_syms.include? template
  end

  def can_use_template? template; return true; end

  def programme_list
    hash = Category::Day.names.reduce({}){|ret,name|ret[name]=[];ret} 
    programme_lists.each{|pl|hash[pl.day]<<pl}
    hash
  end

  def to_programme_list_builder
    hash = Category::Day.names.reduce({}){|ret,name|ret[name]=[];ret} 
    programme_lists.each{|pl|hash[pl.day]<<pl.to_base_builder.attributes!}
    {list:hash}
  end

  def to_detail_builder
    json = to_base_builder
    json.detail do
      json.attributes!.merge! detail.to_base_builder.attributes!
      json.programmes(programmes.includes(:hosts).map{|p|p.to_base_builder.attributes!})
    end
    json
  end

end
