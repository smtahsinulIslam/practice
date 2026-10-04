class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :statement, presence: true
end
