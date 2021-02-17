class Message < ApplicationRecord
  validates :content, :status, presence: true
  belongs_to :user
  belongs_to :conversation
end
