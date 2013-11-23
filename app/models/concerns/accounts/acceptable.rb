module Accounts::Acceptable
  extend  ActiveSupport::Concern

  def accepted?
    !!accepted_at
  end

  def accept
    self.accepted_at = Time.now.utc
  end

  def reject
    self.accepted_at = nil
  end

  included do
    scope :accepted, -> { where.not(accepted_at: nil) }
  end

  extend Share::Exclamation
  define_exclamation_and_method :accept
  define_exclamation_and_method :reject

end
