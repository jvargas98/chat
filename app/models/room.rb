class Room < ApplicationRecord
  belongs_to :conversation, inverse_of: :rooms
  belongs_to :user, inverse_of: :rooms
end
