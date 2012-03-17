class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :confirmable, :lockable, :timeoutable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
