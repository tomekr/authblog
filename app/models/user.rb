class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts

  after_create :assign_default_role

  private

  def assign_default_role
    self.add_role(:default) if self.roles.blank?
  end
end
