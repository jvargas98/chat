class Conversation < ApplicationRecord
  after_initialize :get_message_colors
  attr_reader :message_colors
  validates :name, presence: true
  attribute :status, :boolean, default: true
  has_many :messages, dependent: :destroy
  has_many :rooms, inverse_of: :conversation, dependent: :destroy
  has_many :users, through: :rooms

  def get_message_colors
     colors_hash = {}
     self.users.each do |user|
       colors_hash[user.id] = "##{SecureRandom.hex(3)}" 
      end
     @message_colors = colors_hash
  end
end
