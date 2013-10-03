class Accounts::Provider < Accounts::Account
  include Accounts::RqrcodeTokenable

  set_detail_class Accounts::ProviderDetail

  has_many :hosts, class_name: 'Bcst::Host'
  has_many :programmes, class_name: 'Bcst::Programme'
  has_many :programme_lists, class_name: 'Bcst::ProgrammeList'

  def programme_list
    hash = (0..6).reduce({}) { |ret, day| ret[day.to_s] = []; ret } 
    programme_lists.each { |pl| hash[pl.day.to_s] << pl }
    hash
  end

  validates_presence_of :type

end
