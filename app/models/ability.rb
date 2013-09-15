class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    
    user ||= User.new # guest user (not logged in)
    case user.user_type
    when :admin
      # superadmin
      if user.id == 1
        # can :manage, :all
      end

      can :use, Admins::AdminsController
      can :use, Admins::UsersController
      can :use, Admins::DealersController

      can :manage, Admin, id: user.id
      can :manage, [Dealer, Provider, User]
      
      # no one can destroy superadmin
      cannot :manage, Admin, id: 1

    when :guest

    when :provider
      can :use, SettingsController
      can :use, Users::InverseFriendsController

    when :dealer
      can :use, SettingsController
      can :use, Tips::DashboardsController
      can :use, Users::InverseFriendsController
      can :use, Users::ReviewsController

      # if user.accepted?
        can :use, Tips::CleaningsController
        can :use, Tips::MendingsController
        can :use, Tips::ActivitiesController
        can :use, Tips::BulkPurchasingsController
      # end
      
    when :user
      can :destroy, [Post, Comment], user_id: user.id
      can :update, Order, user_id: user.id
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
