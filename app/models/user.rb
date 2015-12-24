class User < ActiveRecord::Base
  ROLES = %i[admin moderator author banned]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:mobile]


  def email_required?
    false
  end

  def admin?
    #return self.roles.include? 'admin'
    true
  end
end
