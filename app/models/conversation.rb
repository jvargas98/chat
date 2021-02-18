class Conversation < ApplicationRecord
  validates :name, :status, presence: true
  has_many :messages, dependent: :destroy
  has_many :rooms
  has_many :users, through: :rooms
end
