module Accounts::Acceptable
  extend  ActiveSupport::Concern

  def accepted?
    !!accepted_at
  end

  def accept!
    self.accepted_at = Time.now.utc
    save(:validate => false)
  end

  def reject!
    self.accepted_at = nil
    save(:validate => false)
  end

  module ClassMethods

  end
end
