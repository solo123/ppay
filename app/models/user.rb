class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable,
          :rememberable, :trackable,:validatable
  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  # attr_accessor :login
  # def login=(login)
  #   @login = login
  # end

  # def login
  #   @login || self.mobile || self.email
  # end
  # #
  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if login = conditions.delete(:login)
  #     where(conditions).where(["lower(mobile) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     if conditions[:mobile].nil?
  #       where(conditions).first
  #     else
  #       where(mobile: conditions[:mobile]).first
  #     end
  #   end
  # end
  #
  #

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:mobile]

  def email_required?
    false
  end
end
