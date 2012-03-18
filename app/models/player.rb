class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :encryptable, :lockable, :timeoutable

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
end
