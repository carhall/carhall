class Accounts::Agent < Accounts::Distributor

  def agent?
    true
  end

  def user_type
    :distributor
  end
  
end
