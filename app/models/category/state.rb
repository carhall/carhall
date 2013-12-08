class Category::State < ActiveEnum::Base
  States = %w(未完成 已完成 已取消 未启用)
  Lookup = {
    "未完成" => 1,
    "已完成" => 2,
    "已取消" => 3,
    "未启用" => 4,
    "unfinished" => 1,
    "finished" => 2,
    "canceled" => 3,
    "disabled" => 4,
    "enabled" => [1, 2],
  }

  value States
  
  class << self
    def get(index)
      return nil if index.nil?
      if index.is_a? Fixnum
        row = store.get_by_id(index)
        row[1] if row
      else
        Lookup[index.to_s]
      end
    end
    alias_method :[], :get
  end
end