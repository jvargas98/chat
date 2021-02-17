class Conversation < ApplicationRecord
  validates :name, :status, presence: true
  has_many :messages, dependent: :destroy
  belongs_to :user
end
