module Accounts::Rankable
  extend  ActiveSupport::Concern

  included do
    enumerate :rank, with: %w(体验会员 普通会员 金卡会员 钻石会员)
    scope :ranked, -> { order('rank_id DESC') } 
  end

  def rank_up
    self.rank_id += 1 if rank_up?
  end

  def rank_down
    self.rank_id -= 1 if rank_down?
  end

  def rank_up?
    rank_id < 4
  end

  def rank_down?
    rank_id > 1
  end

  extend Share::Exclamation
  define_exclamation_and_method :rank_up
  define_exclamation_and_method :rank_down
  
end
