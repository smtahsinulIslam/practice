class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :number, presence: true, uniqueness: true

  has_many :posts
  has_many :comments
end
