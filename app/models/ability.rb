class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    alias_action :expose, :hide, :stick, :unstick, :to => :set_displayable
    alias_action :mending, :cleaning, :bulk_purchasing, :to => :read

    user ||= Accounts::User.new # guest user (not logged in)
    case user.user_type
    when :admin
      if user.superadmin?
        can :manage, :all  # superadmin
      else
        can :manage, :all  # superadmin
        cannot :motify, Accounts::Admin
      end

      # no one can destroy superadmin

    when :guest

    when :provider
      can :manage, :setting
      can :read, Accounts::Friendship

      can :read, Bcst
      # if user.accepted?
        can :manage, Bcst::Host, provider: user
        can :manage, Bcst::Programme, provider: user
        can :manage, Bcst::ProgrammeList, provider: user
        can :manage, Bcst::Comment, provider: user

        can :read, Bcst::Exposure, provider: user
        can :read, Bcst::TrafficReport, provider: user
      # end

      cannot :set_displayable, :all
    when :dealer
      can :manage, :setting
      can :read, Accounts::Friendship

      can :read, Tips
      # if user.accepted?
        can :manage, Tips::Cleaning, dealer: user
        can :manage, Tips::Mending, dealer: user
        can :manage, Tips::Activity, dealer: user
        can :manage, Tips::BulkPurchasing, dealer: user
        
        can :read, Tips::Review
        can :read, Tips::Order
      # end
      
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
    
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
