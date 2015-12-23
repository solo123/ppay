class User < ActiveRecord::Base
  ROLES = %i[admin moderator author banned]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:mobile]


  def email_required?
    false
  end

  # 权限判断放在ability
  # def admin?
  #   return self.email == 'helapu@pooul.cn'
  # end
end
