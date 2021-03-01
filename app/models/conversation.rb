class Conversation < ApplicationRecord
  validates :name, presence: true
  attribute :status, :boolean, default: true
  has_many :messages, dependent: :destroy
  has_many :rooms, inverse_of: :conversation, dependent: :destroy
  has_many :users, through: :rooms
end
