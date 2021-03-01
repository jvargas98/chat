class Message < ApplicationRecord
  validates :content, presence: true
  attribute :status, :boolean, default: true
  belongs_to :user
  belongs_to :conversation
  has_one_attached :image

  def alive?
   status
  end

  end
