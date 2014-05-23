class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    alias_action :expose, :hide, :stick, :unstick, :to => :set_displayable
    alias_action :mending, :cleaning, :test_drive, :bulk_purchasing, 
      :bulk_purchasing2, :vip_card, :to => :read

    user ||= Accounts::User.new # guest user (not logged in)
    case user.user_type
    when :admin
      if user.superadmin?
        can :manage, :all  # superadmin
      else
        can :manage, :all  # superadmin
        cannot [:update, :destroy, :create], Accounts::Admin
        can :update, Accounts::Admin, id: user.id
        cannot :destroy, Accounts::Account
      end
      # no one can destroy superadmin
      cannot :destroy, Accounts::Admin, id: 1

    when :guest
      can :read, Tips::Mending
      can :read, Tips::Cleaning
      can :read, Tips::TestDrive
      can :read, Tips::Activity
      can :read, Tips::BulkPurchasing
      can :read, Tips::VipCard

    when :provider
      can :manage, :setting
      can :read, Accounts::Friendship

      can :read, Bcst
      if user.accepted?
        can :manage, Bcst::Host, provider: user
        can :manage, Bcst::Programme, provider: user
        can :manage, Bcst::ProgrammeList, provider: user
        can :manage, Bcst::Comment, provider: user

        can :read, Bcst::Exposure, provider: user
        can :read, Bcst::TrafficReport, provider: user
      end

      cannot :set_displayable, :all
    when :dealer
      can :manage, :setting
      can :read, Accounts::Friendship

      can :read, Tips
      if user.accepted?
        can :manage, Tips::Mending, dealer: user
        can :manage, Tips::Cleaning, dealer: user
        can :manage, Tips::TestDrive, dealer: user
        can :manage, Tips::Activity, dealer: user
        can :manage, Tips::BulkPurchasing, dealer: user
        can :manage, Tips::VipCard, dealer: user
        
        can :manage, Statistic::SalesCase, dealer: user

        can :read, Tips::Review
        can :read, Tips::Order

        can :enable, Tips::Order, dealer: user
      end
      
      can :manage, Tips::PurchaseRequesting, dealer: user
      
      cannot :set_displayable, :all
    when :distributor
      can :manage, :setting
      can :read, Accounts::Friendship

      can :read, Tips
      if user.accepted?
        can :manage, Tips::BulkPurchasing2, distributor: user
        can :manage, Tips::ManualImage, distributor: user
        
        can :read, Tips::Order
        can :read, Tips::BulkPurchasing2Order
      end

      if user.agent?
        can :read, Accounts::User, area_id: user.main_area_range
        can :read, Accounts::Dealer, area_id: user.main_area_range
        can :read, Accounts::Distributor, area_id: user.main_area_range
      end
      
      cannot :set_displayable, :all
    when :user
      can :read, :all
      can :manage, Share::Comment, user: user

      can :manage, Posts::Post, user: user
      can :manage, Posts::Club, president: user

      can :manage, Bcst::Exposure, user: user
      can :manage, Bcst::TrafficReport, user: user
      
      can :manage, Tips::Order, user: user
      
      cannot :set_displayable, :all
    end
    
  end
end
