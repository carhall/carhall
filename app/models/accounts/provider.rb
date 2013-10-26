class Accounts::Provider < Accounts::Account
  include Accounts::Publicable
  include Accounts::RqrcodeTokenable

  set_detail_class Accounts::ProviderDetail
  
  has_many :hosts, class_name: 'Bcst::Host'
  has_many :programmes, class_name: 'Bcst::Programme'
  has_many :programme_lists, class_name: 'Bcst::ProgrammeList'

  has_many :exposures, class_name: 'Bcst::Exposure'
  has_many :traffic_reports, class_name: 'Bcst::TrafficReport'

  validates_presence_of :type

  def has_template? template
    detail.template_syms.include? template
  end

  def programme_list
    hash = Category::Day.names.reduce({}) { |ret, name| ret[name] = []; ret } 
    programme_lists.each { |pl| hash[pl.day] << pl }
    hash
  end

  def programme_list_as_api_response
    hash = Category::Day.names.reduce({}) { |ret, name| ret[name] = []; ret } 
    programme_lists.each { |pl| hash[pl.day] << pl.as_api_response(:base) }
    { list: hash }
  end

  api_accessible :detail, extend: :detail, includes: [:programmes] do |t|
    t.add :programmes, template: :base, append_to: :detail
  end
end
