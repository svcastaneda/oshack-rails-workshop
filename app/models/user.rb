class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  validates_presence_of   :name, :username, :email, :password
  validates_uniqueness_of :username, :email
end
