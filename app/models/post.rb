class Post < ApplicationRecord
  resourcify

  has_many :users, -> { distinct }, through: :roles, class_name: 'User', source: :users
  has_many :authors, -> { where(roles: {name: :author}) }, through: :roles, class_name: 'User', source: :users

  belongs_to :user
end
