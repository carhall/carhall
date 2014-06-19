module Accounts::Rankable
  extend  ActiveSupport::Concern

  
  included do
    Ranks = %w(体验会员 普通会员 黄金会员 白金会员 钻石会员)

    enumerate :rank, with: Ranks
    scope :ranked, -> { order('rank_id DESC') } 
    
    def human_rank
      accepted? ? rank : '未验证会员'
    end
  end

  def rank_up
    self.rank_id += 1 if rank_up?
  end

  def rank_down
    self.rank_id -= 1 if rank_down?
  end

  def rank_up?
    rank_id < Ranks.length
  end

  def rank_down?
    rank_id > 1
  end

  extend Share::Exclamation
  define_exclamation_and_method :rank_up
  define_exclamation_and_method :rank_down
  
end
