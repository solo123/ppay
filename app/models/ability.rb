class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    # 根据user判断其身份
    if user.email.to_s.eql? 'helapu@pooul.cn'
      can :manage, :all # [ImpQfCustomer, ImpQfTrade, ImpLog, ImpQfClearing]ß
    else
      can :read, [Address, Client, Contact, PosMachine, Salesman]
    end

  end

end
