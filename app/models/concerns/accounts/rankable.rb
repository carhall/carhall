module Accounts::Rankable
  extend  ActiveSupport::Concern

  included do
    enumerate :rank, with: %w(普通会员 托管优护会员 白金会员)
  end

  def rank_up
    self.rank_id += 1 if rank_up?
  end

  def rank_down
    self.rank_id -= 1 if rank_down?
  end

  def rank_up?
    rank_id < 3
  end

  def rank_down?
    rank_id > 1
  end

  extend Share::Exclamation
  define_exclamation_and_method :rank_up
  define_exclamation_and_method :rank_down
  
end
