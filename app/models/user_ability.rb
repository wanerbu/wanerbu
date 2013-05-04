class UserAbility

  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities

    # guest admin (not logged in)
    user ||= User.new 

    # 给常用的增删改查取一个别名
    alias_action :create,:read,:index,:edit,:update,:destroy, :to => :crud

    # can :manage, Admin if user.ability? :manage_admin
    #当前用户只能操作自己的资源
    if user.ability? :manage_gym
      can [:index], Gym, :user_id => user.id
      #can [:edit,:update], Gym, :user_id => user.id,:status => ['draft','canceled']
      can [:apply], Gym, :user_id => user.id,:status => ['draft','canceled','rejected']
      can [:cancel], Gym, :user_id => user.id,:status => 'applying'
      can [:release], Gym, :user_id => user.id,:status => ['applied','suspended']
      can [:suspend], Gym, :user_id => user.id,:status => 'released'
      can [:destroy,:edit,:update], Gym, :user_id => user.id
      cannot [:edit,:update], Gym,:status => 'applying'
      cannot [:destroy], Gym,:status => ['applying','released','suspended']
    end
  end
 end
