class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= Accounts::User.new # guest user (not logged in)
    case user.user_type
    when :superadmin
      can :manage, :all

    when :admin
      can :manage, Accounts::Admin, id: user.id
      can :manage, [Accounts::Dealer, Accounts::Provider, Accounts::User]
      
      # no one can destroy superadmin
      cannot :manage, Accounts::Admin, id: 1

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
        can :manage, Bcst::Exposure, provider: user
        can :manage, Bcst::TrafficReport, provider: user
      # end

    when :dealer
      can :manage, :setting
      can :read, Accounts::Friendship
      can :manage, Tips::Review

      can :read, Tips
      # if user.accepted?
        can :manage, Tips::Cleaning, dealer: user
        can :manage, Tips::Mending, dealer: user
        can :manage, Tips::Activity, dealer: user
        can :manage, Tips::BulkPurchasing, dealer: user
      # end
      
    when :user
      can :destroy, [Posts::Post, Share::Comment], user: user
      can :destroy, [Bcst::Exposure, Bcst::TrafficReport], user: user
      can :update, Tips::Order, user: user
      can :update, Posts::Club, president: user
      
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
