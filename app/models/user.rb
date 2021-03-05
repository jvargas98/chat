class User < ApplicationRecord
  before_create :assignate_default_avatar
  attr_accessor :messages_color
  # Include default devise modules. Others available are:
  #
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :user_name, :name, presence: true
  has_many :rooms, inverse_of: :user
  has_many :conversations, through: :rooms
  has_many :messages
  has_one_attached :image

  validates :image, 
    content_type: [:png, :jpg, :jpeg],
    dimension: { width: { min: 200, max: 2080 }, height: { min: 200, max: 2080 } }

  
   private
   def assignate_default_avatar
     AvatarAsignator.call(self)
   end
end
