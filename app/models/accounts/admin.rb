class Accounts::Admin < Accounts::Account

  def admin?; true; end

  def superadmin?
    if self.id == 1 then true else false end
  end

end
